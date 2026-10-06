import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trackizer/database/db_model.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'trackizer.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        isFrom TEXT NOT NULL,
        categoryName TEXT NOT NULL,
        description TEXT,
        subCategory TEXT,
        amount TEXT NOT NULL,
        startDate TEXT,
        expiryDate TEXT,
        cardNumber TEXT,
        cVV TEXT,
        totalBudget TEXT,
        imagePath TEXT
      )
    ''');
  }

  Future<ExpenseManagementModel> insert(ExpenseManagementModel expModel) async {
    var dbClient = await db;
    await dbClient.insert("expenses", expModel.toMap());
    return expModel;
  }

  Future<List<ExpenseManagementModel>> getExpenseDetails() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient.query(
      "expenses",
    );
    return queryResult.map((e) => ExpenseManagementModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete("expenses", where: 'id=?', whereArgs: [id]);
  }

  Future<int> update(ExpenseManagementModel expModel) async {
    var dbClient = await db;
    return await dbClient.update(
      "expenses",
      expModel.toMap(),
      where: 'id=?',
      whereArgs: [expModel.id],
    );
  }
}
