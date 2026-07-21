import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/items/data/ebayitem_dto.dart';
import 'package:chat_shop/src/core/items/data/search_dto.dart';
import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ItemsLocaldb {
  Database? _db;
  Future<Database> initdb() async {
    final path = await getDatabasesPath();
    final dbpath = join(path, 'cart.db');

    if (_db != null) {
      return _db!;
    } else {
      _db = await openDatabase(
        dbpath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''CREATE TABLE cart(
        itemId TEXT PRIMARY KEY,
        title TEXT,
        imageUrl TEXT,
        inrprice REAL,
        shortDescription TEXT,
        quantity INTEGER
        )''');
        },
      );

      return _db!;
    }
  }

  Future<Result<void>> savedb(SearchDomain item) async {
    try {
      final db = await initdb();
      final cartitem = SearchDto(
        itemId: item.itemId,
        title: item.title,
        description: item.description,
        imageUrl: item.imageUrl,
        inrprice: item.inrprice,
        quantity: item.quantity,
      );
      await db.insert(
        'cart',
        cartitem.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      return Result.onfailure(e.toString());
    }
    return Result.onSuccess(null);
  }

  Future<Result<List<SearchDomain>?>> loaditems() async {
    try {
      final db = await initdb();

      final query = await db.query('cart');
      final item = query.map((item) {
        final detail = EbuyItemsDetails.fromjson(item);
        return SearchDto.fromdetaildto(detail, null).toDomain();
      }).toList();

      if (item.isNotEmpty) {
        return Result.onSuccess(item);
      } else {
        return Result.onSuccess(null);
      }
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  Future<Result<bool>> clearCart() async {
    try {
      final db = await initdb();
      await db.delete('cart');
      return Result.onSuccess(true);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  Future<Result<void>> updatequantity(String itemId, int quantity) async {
    try {
      final db = await initdb();

      await db.update(
        'cart',
        {'quantity': quantity},
        where: 'itemId=?',
        whereArgs: [itemId],
      );

      return Result.onSuccess(null);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  Future<Result<void>> deleteItem(String itemid) async {
    try {
      final db = await initdb();
      await db.delete('cart', where: 'itemId=?', whereArgs: [itemid]);
      return Result.onSuccess(null);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  Future<bool> istemexist(String itemid) async {
    final db = await initdb();
    final item = await db.query(
      'cart',
      where: 'itemId=?',
      whereArgs: [itemid],
      limit: 1,
    );
    return item.isNotEmpty;
  }
}
