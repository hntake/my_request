import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper{

  String serverUrl = "http://localhost/api";
  var status ;

  var token ;

  loginData(String email , String password) async{

    String myUrl = "$serverUrl/login";
    final response = await http.post(Uri.parse(myUrl),
        headers: {
          'Accept':'application/json',
          'Access-Control-Allow-Origin': '*', // CORS設定
          'Access-Control-Allow-Methods': 'POST', // CORS設定
        },
        body: {
          "email": "$email",
          "password" : "$password"
        } ) ;
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if(status){
      print('data : ${data["error"]}');
    }else{
      print('data : ${data["token"]}');
      _save(data["token"]);
    }

  }

  registerData(String name ,String email , String password) async{

    String myUrl = "$serverUrl/register";
    final response = await http.post(Uri.parse(myUrl),
        headers: {
          'Accept':'application/json'
        },
        body: {
          "name": "$name",
          "email": "$email",
          "password" : "$password"
        } ) ;
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if(status){
      print('data : ${data["error"]}');
    }else{
      print('data : ${data["token"]}');
      _save(data["token"]);
    }

  }


  Future<List> getData() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/my_page";
    http.Response response = await http.post(Uri.parse(myUrl),
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
        });
    return json.decode(response.body);
  }



  void editData(int id,String name , String email ,String tel1 ,String tel2 ,) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "http://localhost/api/update_user_fl/$id";
    http.post(Uri.parse(myUrl),
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value',
          'Access-Control-Allow-Origin': '*', // CORS設定
          'Access-Control-Allow-Methods': 'POST', // CORS設定
        },
        body: {
          "name": "$name",
          "email" : "$email",
          "tel1" : "$tel1",
          "tel2" : "$tel2",

        }).then((response){
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }




  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }


  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
    print('read : $value');
  }






}

