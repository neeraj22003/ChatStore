import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepository {
  final User? currentuser;
  ChatRepository(this.currentuser);
  String getchatid(String secondguyid) {
    List<String> ids = [currentuser?.uid ?? '', secondguyid];
    ids.sort();
    return ids.join('_');
  }

  Future<void> sendmessage(
    String secondguy,
    String secondguyid,
    String getchatid,
    String lassmessage,
    String sender,
  ) async {
    final curremtid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('messages').doc(getchatid).set({
      'participants': [curremtid, secondguyid],
      'sender': sender,
      'receiver': secondguy,
      'senderId': curremtid,
      'receiverId': secondguyid,
      'lastMessage': lassmessage,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    await FirebaseFirestore.instance
        .collection('messages')
        .doc(getchatid)
        .collection('chats')
        .add({
          'senderId': curremtid,
          'receiverId': secondguyid,
          'message': lassmessage,
          'timestamp': FieldValue.serverTimestamp(),
        });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> histchats() {
    return FirebaseFirestore.instance
        .collection('messages')
        .where('participants', arrayContains: currentuser?.uid)
        .snapshots();
  }
}
