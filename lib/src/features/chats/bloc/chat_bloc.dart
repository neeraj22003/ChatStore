import 'package:chat_shop/src/core/user/domain/user_usecases/user_usecase.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_event.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_state.dart';
import 'package:chat_shop/src/features/chats/domain/chat_domain.dart';
import 'package:chat_shop/src/features/chats/domain/use_cases/chat_usecase/chat_use_cases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUseCases chatUseCases;
  final UserUsecase userUsecase;
  String cachecurrentuserId = '';
  ChatBloc(this.chatUseCases, this.userUsecase) : super(ChatisInitial()) {
    on<Sendmessage>((event, emit) async {
      if (event.history.lastmessage!.isEmpty) return;
      final current = await userUsecase.getUser();
      if (current.isFailure || current.data == null) {
        emit(Chaterror(current.error ?? "User not authenticated"));
      }

      final message = await chatUseCases.sendMessage.call(event.history);

      if (message.isFailure) {
        emit(Chaterror(message.error));
      }
    });
    on<CreateChatdoc>((event, emit) async {
      emit(Chatloading());
      final current = await userUsecase.getUser();
      if (current.isFailure) {
        emit(Chaterror(current.error));
      }
      cachecurrentuserId = current.data!.id;
      final result = await chatUseCases.createChatDoc.call(
        event.chatuserId,
        cachecurrentuserId,
      );
      if (result.isFailure) {
        emit(Chaterror(result.error));
      }
      add(LoadMessage(event.chatuserId));
    });
    on<LoadMessage>((event, emit) async {
      final result = chatUseCases.loadMessages.call(
        event.chatuserid,
        cachecurrentuserId,
      );

      if (result.isFailure) {
        emit(Chaterror(result.error));
      }

      await emit.forEach<List<ChatDomain>>(
        result.data!,
        onData: (data) {
          if (data.isEmpty) return ChatisInitial();
          return Chatloaded(data, cachecurrentuserId);
        },
        onError: (error, stackTrace) {
          return Chaterror(error.toString());
        },
      );
    });
    on<ResetChatstate>((event, emit) => ChatisInitial());
  }
}
