import 'package:chat_shop/src/core/layout/notfiers/notifiers.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_domain.dart';
import 'package:chat_shop/src/features/chat_history/notifiers/notifiers.dart';
import 'package:chat_shop/src/injecters.dart';

class Reseter {
  void call() {
    di<ChatNotifiers>().historyNotifier.value = ChatHistoryDomain();
    di<ChatNotifiers>().selectchatid.value = '';
    di<Not>().navigationIndex.value = 0;
  }
}
/*This should call inside logout button callback , so all 
 Bloc/Cubit or valunotfiers State go to their Initial State so, next 
 login wont show stale states to diffrent users*/