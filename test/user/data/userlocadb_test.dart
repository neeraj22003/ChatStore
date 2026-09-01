import 'package:chat_shop/src/core/user/data/user_localdbimpl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  test('testing userdb if it working or not ', () async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    final path = join(await getDatabasesPath(), 'test.db');
    final userdb = await UserLocaldbimpl().initDb(path);
    await userdb.insert('user', {'id': '123'});
    final check = await userdb.query('user');
  
    expect(check.first['id'], '123');
  });
}
