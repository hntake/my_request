import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_request/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';


class PainPage extends StatefulWidget {
  List list;
  int index;
  final SharedPreferences preferences; // 追加



  PainPage(
      {required this.list, required this.index, required this.preferences});

  @override
  _PainPageState createState() => _PainPageState();
}
class _PainPageState extends State<PainPage> {
  bool isLoading = false;
  late SharedPreferences preferences; // ここで preferences フィールドを宣言
  late FlutterTts flutterTts; // FlutterTts インスタンスをフィールドとして宣言

  _PainPageState() {
    SharedPreferences.getInstance().then((sharedPreferences) {
      preferences = sharedPreferences;
      flutterTts = FlutterTts(); // フィールドに初期化したインスタンスを代入
      initializeTTS(); // Flutter TTSの初期化をここで呼び出す
    });

  }
  void initializeTTS() async {
    final flutterTts = FlutterTts();
    await flutterTts.setLanguage('ja-JP');
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0);
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      readAloudInAngryPage(); // ページが初期化されたら読み上げを開始
    });

  }
  // 読み上げ関数
  void readAloudInAngryPage() {
    flutterTts.setLanguage('ja-JP');
    flutterTts.setSpeechRate(1.0);
    flutterTts.setPitch(1.0);
    flutterTts.setVolume(1.0);

    final message1 = widget.preferences.getString('message3') .toString();
    final message2 = widget.preferences.getString('message4') .toString();

    flutterTts.speak(message1);

    Future.delayed(Duration(seconds: 3), () {
      flutterTts.speak(message2);
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: <Widget>[
                    if ('${preferences.getString('message3').toString()}' != null)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${preferences.getString('message3').toString()}'),
                      ),
                    Image.asset('images/pain.png', width: 100),
                    if ('${preferences.getString('message4').toString()}' != null)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${preferences.getString('message4').toString()}'),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // ボタンがクリックされたときの処理をここに追加
                  // 例: ページを戻る
                  Navigator.of(context).pop();
                },
                child: Text('アイコン選択に戻る'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
