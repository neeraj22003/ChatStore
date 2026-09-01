import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/data/user_domain_dto.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/core/user/domain/user_localdb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class UserLocaldbimpl implements UserLocaldb {
  final User? user;
  Database? _db;
  UserLocaldbimpl(this.user);
  Future<Database> initDb({String? path}) async {
    if (_db != null) {
      return _db!;
    }
    final dbpath = await getDatabasesPath();
    final joinedpath = (path == null || path.isEmpty)
        ? join(dbpath, 'user.db')
        : path;
    _db = await openDatabase(
      joinedpath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE user(
         id TEXT PRIMARY KEY,
         name TEXT,
         query TEXT,
         email TEXT,
         phone TEXT,
         address TEXT,
         profileimage TEXT )''');
      },
    );
    return _db!;
  }

  @override
  Future<Result<UserDomain?>> getUser() async {
    try {
      final db = await initDb();

      final result = await db.query(
        'user',
        where: 'id=?',
        whereArgs: [user?.uid ?? FirebaseAuth.instance.currentUser?.uid],
      );
      if (result.isNotEmpty) {
        print('beatuty');
        final userdata = UserDto.fromJson(result.first).toDomain();
        return Result.onSuccess(userdata);
      }
      return Result.onfailure(null);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  @override
  Future<Result<bool>> saveUser(UserDomain user) async {
    try {
      final userdto = UserDto(
        id: user.id,

        name: user.name,
        address: user.address,
        email: user.email,
        phone: user.phone,
        profileimage: user.profileimage,
      );
      final db = await initDb();
      final result = await db.insert(
        'user',
        userdto.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (result > 0) {
        print('save');
        return Result.onSuccess(result > 0);
      }
      print('fail');
      return Result.onfailure('something went wrong during inserting in db');
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  @override
  Future<Result<bool>> deletelocaluser() async {
    try {
      final db = await initDb();
      await db.delete('user');
      return Result.onSuccess(true);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  @override
  Future<Result<bool>> updateprofile(String? url) async {
    if (url == null || url.isEmpty) {
      return Result.onfailure('url is empty');
    }

    try {
      final db = await initDb();
      await db.update('user', {'profileimage': url});
      return Result.onSuccess(true);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }
}
