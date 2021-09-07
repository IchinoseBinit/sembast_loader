import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastHelper {
  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    return await createDatabase();
  }

  Future<Database?> createDatabase() async {
    String dbPath = 'countries.db';
    var dir = await getApplicationDocumentsDirectory();
    final database = await databaseFactoryIo.openDatabase(
      join(
        dir.path,
        dbPath,
      ),
      version: 1,
    );
    return database;
  }

  Future<List?> readData() async {
    final Database? database = await db;
    var store = StoreRef.main();
    if (database != null) {
      final record = await store.record('countries').get(database) as List?;
      if (record != null) {
        return record;
      }
      return null;
    } else {
      throw Exception("Cannot find the database");
    }
  }

  writeData(List obj) async {
    final Database? database = await db;

    var store = StoreRef.main();
    return await store.record('countries').put(database!, obj);
  }
}
