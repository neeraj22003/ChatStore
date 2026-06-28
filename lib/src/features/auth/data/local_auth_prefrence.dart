import 'dart:convert';

import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthPrefrence {
  final String hasUser = 'hasUser';

  Future<void> saveUser(AuthDomain value) async {
    final setuser = await SharedPreferences.getInstance();
    await setuser.setString(hasUser, jsonEncode(value.toJson()));
  }

  Future<AuthDomain?> getUser() async {
    final getuser = await SharedPreferences.getInstance();
    final user = getuser.getString(hasUser);
    if (user == null) return null;
    return AuthDomain.fromJson(jsonDecode(user));
  }
}
