import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/orders/data/order_dto.dart';
import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class OrderLocaldb {
  Database? _db;

  Future<Database> initdb() async {
    final path = await getDatabasesPath();
    final dbpath = join(path, 'orders');

    if (_db != null) {
      return _db!;
    } else {
      _db = await openDatabase(
        dbpath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''CREATE TABLE orders(
         orderid TEXT PRIMARY KEY,
         name TEXT,
         phone TEXT,
         address TEXT,
         items TEXT,
         total TEXT,
         createdAT TEXT
      )''');
        },
      );
      return _db!;
    }
  }

  Future<Result<String>> saveOrder(Orders order) async {
    try {
      final db = await initdb();
      final orderdto = OrdersDto(
        orderId: order.orderId,
        name: order.name,
        phone: order.phone,
        address: order.address,
        total: order.total,
        items: order.items,
      );
      final result = await db.insert('orders', orderdto.toSqJson());
      return Result.onSuccess(result.toString());
    } catch (e) {
      print('savelocal${e.toString()}');
      return Result.onfailure(e.toString());
    }
  }

  Future<Result<List<Orders>>> getOrder() async {
    try {
      final db = await initdb();
      final result = await db.query('orders');
      print('ordersLocaDb=${result.length}');
      if (result.isEmpty) {
        return Result.onSuccess([]);
      } else {
        final order = result
            .map((data) => OrdersDto.fromdb(data).toDomain())
            .toList();
        return Result.onSuccess(order);
      }
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  Future<Result<bool>> deleteOrder(String orderid) async {
    try {
      final db = await initdb();
      await db.delete('orders', where: 'orderid=?', whereArgs: [orderid]);
      return Result.onSuccess(true);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }
}
