import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_local_storage/urls.dart';
import 'package:sembast_local_storage/utilities/api_call.dart';
import 'package:sembast_local_storage/utilities/sembast_helper.dart';

class DataLoader {
  final sembast = SembastHelper();

  _createDatabase() async {
    await sembast.createDatabase();
  }

  Future<List?> _readDatabaseData() async {
    return sembast.readData();
  }

  Future<List?> loadData(String url) async {
    try {
      await _createDatabase();
      List? record;
      // checks whether there is data in database, commented to always fetch the data from the internet
      record = await _readDatabaseData();
      if (record == null) {
        final receivePort = ReceivePort();
        Isolate.spawn(
          isolateFunction,
          receivePort.sendPort,
        );
        SendPort childSendPort = await receivePort.first;

        final responsePort = ReceivePort();

        final dir = await getApplicationDocumentsDirectory();
        childSendPort.send([dir.path, responsePort.sendPort]);
        final response = await responsePort.first;
        record = response;
      }
      return record;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  static void isolateFunction(SendPort sendPort) async {
    final childReceivePort = ReceivePort();
    sendPort.send(childReceivePort.sendPort);
    await for (var message in childReceivePort) {
      String path = message[0];
      SendPort replyPort = message[1];

      final record = await ApiCall().fetchData(baseUrl);

      final response = await SembastHelper().writeData(path, record);
      replyPort.send(response);
    }
  }
}
