
import 'package:chat_shop/src/core/user/domain/user_usecases/user_usecase.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_event.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_state.dart';
import 'package:chat_shop/src/features/chats/domain/use_cases/chat_usecase/chat_use_cases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUseCases chatUseCases;
  final UserUsecase userUsecase;
  ChatBloc(this.chatUseCases, this.userUsecase) : super(ChatisInitial()) {
    on<Sendmessage>((event, emit) async {
      final current = await userUsecase.getUser();
      if (current.isFailure) {
        emit(Chaterror(current.error));
      }
      final message = await chatUseCases.sendMessage.call(
        event.chatUserid,
        current.data!.id,
        event.message,
      );
      if (message.isFailure) {
        emit(Chaterror(message.error));
      }
    });

    on<LoadMessage>((event, emit) async {
      final current = await userUsecase.getUser();
      if (current.isFailure) {
        emit(Chaterror(current.error));
      }
      final result = chatUseCases.loadMessages.call(
        event.chatuserid,
        current.data!.id,
      );
      if (result.isFailure) {
        emit(Chaterror(result.error));
      }
      await emit.forEach(
        result.data!,
        onData: (data) {
          return Chatloaded(data,current.data!);
        },
      );
    });
  }
}
