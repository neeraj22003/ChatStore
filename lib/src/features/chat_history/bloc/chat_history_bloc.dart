import 'package:bloc/bloc.dart';
import 'package:chat_shop/src/core/user/domain/user_usecases/user_usecase.dart';
import 'package:chat_shop/src/features/chat_history/bloc/chat_history_event.dart';
import 'package:chat_shop/src/features/chat_history/bloc/chat_history_states.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_use_cases/use_cases.dart';

class ChatHistoryBloc extends Bloc<ChatHistoryEvent, ChatHistoryState> {
  final ChathistoryUseCases chathistoryUseCases;
  final UserUsecase userUsecase;
 
  ChatHistoryBloc(this.chathistoryUseCases, this.userUsecase)
    : super(ChatHistoryInitial()) {
    on<GetChatHistory>((event, emit) async {
      emit(ChatHistoryLoading());
      final getcurrentUser = await userUsecase.getUser();
      if (getcurrentUser.isFailure) {
        emit(ChatHistoryError(getcurrentUser.error));
      }
     
      final result = chathistoryUseCases.getChatHistory.call(getcurrentUser.data!.id);
      if (result.isFailure) {
        emit(ChatHistoryError(result.error));
      }
      await emit.forEach(
        result.data!,
        onData: (data) {
          if (data.isEmpty) {
            return ChatHistoryInitial();
          }
          
          return ChatHistoryLoaded(data,getcurrentUser.data!);
        },
        onError: (error, stackTrace) => ChatHistoryError(error.toString()),
      );
    });

   
  }
}
