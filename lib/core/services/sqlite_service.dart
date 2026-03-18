import 'package:flutter_experiments/features/search/data/search_dto.dart';
import 'package:flutter_experiments/features/search/domain/search_item_domain.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqliteService {
  static final SqliteService _instance = SqliteService._internal();
  factory SqliteService() => _instance;
  SqliteService._internal();

  Future<Database> initdb() async {
    final path = await getDatabasesPath();
    final dbpath = join(path, 'cart.db');
    return openDatabase(
      dbpath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''CREATE TABLE cart(
        itemId TEXT PRIMARY KEY,
        title TEXT,
        imageUrl TEXT,
        price TEXT,
        description TEXT,
        quantity INTEGER
        )''');
      },
    );
  }

  Future<void> savedb(SearchDomain item) async {
    final db = await initdb();
    final cartitem = EbuyItemsDetails(
      itemid: item.itemId,
      title: item.title,
      imageUrl: item.imageUrl,
      price: item.inrprice.toString(),
      description: item.description,
    );
    db.insert(
      'cart',
      cartitem.tojson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SearchDomain>> loaditems() async {
    final db = await initdb();
    final query = await db.query('cart');
    return query.map((item) {
      final detail = EbuyItemsDetails.fromjson(item);
      return SearchDomain.fromdetaildto(detail, null);
    }).toList();
  }
}
