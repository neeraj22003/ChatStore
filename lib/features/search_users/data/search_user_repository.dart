import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class SearchUserRepository {
  Future<QuerySnapshot> searchUserFuture(String query) async {
    try {
      final connection = await http.get(Uri.parse('https://www.google.com'));
      if (connection.statusCode != 200) {
        throw Exception('no internet');
      }
    } on SocketException {
      throw Exception('no internet');
    } on http.ClientException {
      throw throw Exception('no internet');
    } catch (e) {
      throw Exception('something iswrong');
    }

    return FirebaseFirestore.instance
        .collection('users')
        .orderBy('query')
        .startAt([query])
        .endAt(['$query\uf8ff'])
        .get();
  }
}
