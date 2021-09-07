import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sembast_local_storage/urls.dart';
import 'package:sembast_local_storage/utilities/api_call.dart';
import 'package:sembast_local_storage/utilities/data_loader.dart';
import 'package:sembast_local_storage/utilities/sembast_helper.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data from Sembast"),
      ),
      body: FutureBuilder(
        future: DataLoader().loadData(baseUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 18),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Text(
                  snapshot.data.toString(),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
