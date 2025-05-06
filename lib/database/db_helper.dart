// // ignore_for_file: file_names, constant_identifier_names

import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trackizer/database/db_model.dart';

// class DBHelper {
//   static Database? _db;
//   static const String DATABASE_NAME = "trackizer.db";
//   static const int DATABASE_VERSION = 1;
//   static const String TABLE_EXPENSES = "expenses";

//   Future<Database?> get db async {
//     if (_db != null) {
//       return _db;
//     }
//     _db = await initDatabase();
//     return _db;
//   }

//   Future<Database> initDatabase() async {
//     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, DATABASE_NAME);

//     return await openDatabase(
//       path,
//       version: DATABASE_VERSION,
//       onCreate: _onCreate,
//       onUpgrade: _onUpgrade,
//     );
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $TABLE_EXPENSES (
//         id INTEGER PRIMARY KEY,
//         isFrom TEXT NOT NULL,
//         categoryName TEXT NOT NULL,
//         description TEXT,
//         subCategory TEXT,
//         amount TEXT NOT NULL,
//         startDate TEXT,
//         expiryDate TEXT,
//         cardNumber TEXT,
//         cVV TEXT,
//         totalBudget TEXT,
//         imagePath TEXT
//       )
//     ''');
//   }

//   Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     if (oldVersion < 3) {
//       await db.execute("DROP TABLE IF EXISTS $TABLE_EXPENSES;");
//       await _onCreate(db, newVersion);
//     }
//   }

//   Future<void> dropTable() async {
//     var dbClient = await db;
//     await dbClient!.execute("DROP TABLE IF EXISTS $TABLE_EXPENSES;");
//   }

//   Future<void> deleteDatabaseFile() async {
//     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, DATABASE_NAME);
//     await databaseFactory.deleteDatabase(path);
//   }

//   Future<ExpenseManagementModel> insert(ExpenseManagementModel expModel) async {
//     try {
//       var dbClient = await db;
//       await dbClient!.insert(TABLE_EXPENSES, expModel.toMap());
//       return expModel;
//     } catch (e) {
//       throw Exception("Database Insert Error: $e");
//     }
//   }

//   Future<List<ExpenseManagementModel>> getCartDetail() async {
//     try {
//       var dbClient = await db;
//       final List<Map<String, Object?>> queryResult = await dbClient!.query(
//         TABLE_EXPENSES,
//       );
//       return queryResult.map((e) => ExpenseManagementModel.fromMap(e)).toList();
//     } catch (e) {
//       throw Exception("Database Fetch Error: $e");
//     }
//   }

//   Future<int> delete(int id) async {
//     try {
//       var dbClient = await db;
//       return await dbClient!.delete(
//         TABLE_EXPENSES,
//         where: 'id=?',
//         whereArgs: [id],
//       );
//     } catch (e) {
//       throw Exception("Database Delete Error: $e");
//     }
//   }

//   Future<void> deleteAll() async {
//     try {
//       var dbClient = await db;
//       await dbClient!.delete(TABLE_EXPENSES);
//     } catch (e) {
//       throw Exception("Database Delete All Error: $e");
//     }
//   }

//   Future<int> update(ExpenseManagementModel expModel) async {
//     try {
//       var dbClient = await db;
//       return await dbClient!.update(
//         TABLE_EXPENSES,
//         expModel.toMap(),
//         where: 'id=?',
//         whereArgs: [expModel.id],
//       );
//     } catch (e) {
//       throw Exception("Database Update Error: $e");
//     }
//   }
// }

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join("${documentDirectory.path}, trackizer.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
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
