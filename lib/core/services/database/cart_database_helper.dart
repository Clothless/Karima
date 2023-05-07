import 'package:karima/const.dart';
import 'package:karima/model/cart_product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabaseHelper {

  CartDatabaseHelper._();

  static final CartDatabaseHelper db = CartDatabaseHelper._();
  static Database? _database;

  Future<Database?> get database async{
    if(_database != null) return _database;

    _database = await initDB();
    return null;
  }
  
  initDB() async{
    String path = join(await getDatabasesPath(), 'CartProduct.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async{
        await db.execute('''
          CREATE TABLE $tableCartProduct(
            $columnPoductID TEXT NOT NULL,
            $columnName TEXT NOT NULL,
            $columnImage TEXT NOT NULL,
            $columnQuantity TEXT NOT NULL,
            $columnPrice INTEGER NOT NULL)
        ''');
      },
    );
  }

  Future<List<CartProductModel>> getAllProduct() async{
    var dbClient = (await database)!;
    List<Map?> maps = await dbClient.query(tableCartProduct);

    List<CartProductModel> list = maps.isNotEmpty
    ? maps.map((product) => CartProductModel?.fromJson(product!)).toList()
    : [];

    return list;

  }

  insert(CartProductModel model) async{
    var dbClient = (await database)!;
    await dbClient.insert(
      tableCartProduct,
      model.tojson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      );

  }

  updateProduct(CartProductModel model) async{
    var dbClient = (await database)!;
    return await dbClient.update(
      tableCartProduct,
      model.tojson(),
      where: '$columnPoductID = ?',
      whereArgs: [model.productID],
      );
  }
}