import 'dart:convert';

import 'package:my_request/helper/constant.dart';
import 'package:http/http.dart' as http;

class API {
  postRequest({
    required String route,
    required Map<String, String> data,
    String authToken = '',
  }) async {
    String url = 'https://itcha50.com' + route;
    try {
      return await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {
          'Authorization': 'Bearer $authToken', // 認証トークンを設定
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
    } catch (e) {
      print(e.toString());
      return jsonEncode(e);
    }
  }

  putRequest({
    required String route,
    required Map<String, String> data,
    String authToken = '',
  }) async {
    String url = 'https://itcha50.com/' + route;
    final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(data),
      headers: {
        'Authorization': 'Bearer $authToken', // 認証トークンを設定
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
  );
    return response;
  } 
}

  updateData({required String route, required Map<String, String> data}) async {
    final response = await http.put(Uri.parse(route), body: jsonEncode(data));
  }

  _header() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
