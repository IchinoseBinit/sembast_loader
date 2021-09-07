import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastHelper {
  Database? db;
  String dbPath = 'sample.db';

  createDatabase() async {
    var dir = await getApplicationDocumentsDirectory();
    db = await databaseFactoryIo.openDatabase(
      join(
        dir.path,
        dbPath,
      ),
      version: 1,
    );
  }

  Future<List?> readData() async {
    var store = StoreRef.main();
    if (db != null) {
      final record = await store.record('countries').get(db!) as List?;
      if (record != null) {
        return record;
      }
      return null;
    } else {
      throw Exception("Cannot find the database");
    }
  }

  writeData(String path, List obj) async {
    var store = StoreRef.main();
    db = await databaseFactoryIo.openDatabase(
      join(
        path,
        dbPath,
      ),
      version: 1,
    );
    if (db != null) {
      return await store.record('countries').put(db!, obj);
    } else {
      throw Exception("Cannot find the database");
    }
  }
}
