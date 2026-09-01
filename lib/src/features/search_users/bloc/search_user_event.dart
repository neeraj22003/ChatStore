import 'package:flutter/widgets.dart';

abstract class SearchUserEvent {}

class ClearField extends SearchUserEvent {
  final TextEditingController controller;
  ClearField(this.controller);
}

class SearchUser extends SearchUserEvent {
  final String query;
  SearchUser(this.query);
}
