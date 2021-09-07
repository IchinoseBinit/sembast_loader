import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_local_storage/urls.dart';
import 'package:sembast_local_storage/utilities/api_call.dart';
import 'package:sembast_local_storage/utilities/sembast_helper.dart';

_getApiDataAndWriteToDb(int i) async {
  // getting the data from the api
  final record = await ApiCall().fetchData(baseUrl);

  final sembast = SembastHelper();
  // saving and returning the record
  return await sembast.writeData(record);
}

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
    // await sembast.writeData(obj);
  }

  Future<List?> loadData(String url) async {
    // try {
    // await _createDatabase();
    List? record;
    // checks whether there is data in database, commented to always fetch the data from the internet
    // record = await _readDatabaseData();
    if (record == null) {
      // if I do this ani call the function it works if i comment the below 45-47 lines of code
      final response = await _getApiDataAndWriteToDb(1);
      record = response;

      // this calls the next isolate with the top-level function
      // esle chei error dinxa
      final result = await compute(_getApiDataAndWriteToDb, 1);
      print(result);
      record = result;
    }
    return record;
    // } catch (ex) {
    //   throw Exception(ex);
    // }
  }
}
