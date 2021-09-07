import 'package:sembast_local_storage/utilities/api_call.dart';
import 'package:sembast_local_storage/utilities/sembast_helper.dart';

class DataLoader {
  final sembast = SembastHelper();
  _createDatabase() async {
    await sembast.createDatabase();
  }

  _getApiData(String url) async {
    return await ApiCall().fetchData(url);
  }

  Future<List?> _readDatabaseData() async {
    return sembast.readData();
  }

  _writeToDatabase(List obj) async {
    await sembast.writeData(obj);
  }

  Future<List?> loadData(String url) async {
    try {
      await _createDatabase();
      List? record;
      record = await _readDatabaseData();
      if (record == null) {
        record = await ApiCall().fetchData(url);
        await _writeToDatabase(record!);
      }
      return record;
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
