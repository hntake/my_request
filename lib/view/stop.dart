import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StopServiceConfirmationScreen extends StatefulWidget {
  final List<Map<String, dynamic>> list;
  final int index;

  StopServiceConfirmationScreen({required this.list, required this.index});

  @override
  _StopServiceConfirmationScreenState createState() =>
      _StopServiceConfirmationScreenState();
}

class _StopServiceConfirmationScreenState
    extends State<StopServiceConfirmationScreen> {
  void updateData() async {
    int userId = widget.list[widget.index]['id'] ?? 0;
    String idValue = userId.toString();
    if (userId != null) {
      final data = {
        'id': idValue,
        'mode': '2', // モードを0から2に変更するために、'2'と指定
      };

      // モードの変更リクエストを作成
      var uri = Uri.parse('/stop/$idValue');
      var request = http.Request('POST', uri);
      request.headers.addAll({'Content-Type': 'application/json'});
      request.body = json.encode(data); // データをJSON形式にエンコード

      var response = await request.send();
      if (response.statusCode == 200) {
        // モードの変更に成功した場合、home.dartに遷移する
        Navigator.pushNamed(context, '/home');
      } else {
        // モードの変更に失敗した場合、エラーメッセージを表示するなどの処理を行う
        print('モードの変更に失敗しました');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('サービス停止確認画面'),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('紛失等の為にサービスを停止しますか？'),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  updateData();
                },
                child: Text('停止する'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
