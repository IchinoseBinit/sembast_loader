import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiCall {
  Future fetchData(String url) async {
    final response = await http.get(Uri.parse(url)).timeout(
          Duration(
            minutes: 1,
          ),
        );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      throw Exception("Cannot find the data");
    }
  }
}
