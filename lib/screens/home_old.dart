import 'package:my_request/view/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_request/Controllers/databasehelper.dart';
import 'package:my_request/view/dashboard.dart';
import 'package:my_request/methods/api.dart';
import 'package:my_request/helper/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:my_request/view/angry.dart';



class Home extends StatefulWidget {
  final FlutterTts flutterTts; // プロパティを追加
  final Map<String, dynamic>? updatedData; // 追加
  final Map<String, dynamic>? modeData; // 追加

  Home({Key? key, this.updatedData, this.modeData}) 
       : flutterTts = FlutterTts(), // コンストラクタ内で初期化
         super(key: key);
  
  @override
  State<Home> createState() => _HomeState();
}

class EditData extends StatefulWidget {
  final List<dynamic> list;
  final int index;
  final SharedPreferences preferences;
  final Map<String, dynamic>? updatedData; // 追加


  const EditData({
    required this.list,
    required this.index,
    required this.preferences,
    this.updatedData, // 追加

  });


  @override
  _EditDataState createState() => _EditDataState();
}

class _HomeState extends State<Home> {
  late SharedPreferences preferences;
  bool isLoading = false;
  late int mode; // モードの状態を保持する変数を追加


  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    setState(() {
      isLoading = false;
      // 編集後のデータを受け取り、状態を更新する
      if (widget.updatedData != null) {
        preferences.setString('message1', widget.updatedData!['message1']);
        preferences.setString('message2', widget.updatedData!['message2']);
        preferences.setString('message3', widget.updatedData!['message3']);
        preferences.setString('message4', widget.updatedData!['message4']);
        preferences.setString('message5', widget.updatedData!['message5']);
        preferences.setString('message6', widget.updatedData!['message6']);
        preferences.setString('message7', widget.updatedData!['message7']);
        preferences.setString('message8', widget.updatedData!['message8']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ここにウィジェットのビルドコードを追加
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('マイフィーリング'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  readAloud1(['${preferences.getString('message1').toString()}', '${preferences.getString('message2').toString()}']);
                  Navigator.push(
                      context, 
                      MaterialPageRoute(
                          builder: (context) =>  AngryPage(
                            list: [
                              {
                                'message1': preferences.getString('message1'),
                                'message2': preferences.getString('message2'),
                              }
                            ], // 空のリストを渡すか、適切なデータを渡す

                            index: 0, // 適切なインデックスを渡す
                            preferences: preferences,
                          ),
                      ),
                  ).then((updatedData) {
                    if (updatedData != null) {
                      setState(() {
                        // 編集後のデータを受け取り、状態を更新する
                        preferences.setString('message1', updatedData['message1']);
                        preferences.setString('message2', updatedData['message2']);
                      });
                    }
                  });
                },
              child: Image.asset('images/angry.png', width: 100.0),
             ),
              GestureDetector(
                onTap: () {
              readAloud2(['${preferences.getString('message3').toString()}', '${preferences.getString('message4').toString()}']);
               Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) =>  PainPage(
                         list: [
                           {
                             'message3': preferences.getString('message3'),
                             'message4': preferences.getString('message4'),
                           }
                         ], // 空のリストを渡すか、適切なデータを渡す

                         index: 0, // 適切なインデックスを渡す
                         preferences: preferences,
                       ),
                   ),
               ).then((updatedData) {
                 if (updatedData != null) {
                   setState(() {
                     // 編集後のデータを受け取り、状態を更新する
                     preferences.setString('message3', updatedData['message3']);
                     preferences.setString('message4', updatedData['message4']);
                   });
                 }
               });
                },
             
                child: Image.asset('images/pain.png', width: 100.0),
              ),
              GestureDetector(
                onTap: () {
                  readAloud3(['${preferences.getString('message5').toString()}', '${preferences.getString('message6').toString()}']);
                  Navigator.push(
                      context, 
                      MaterialPageRoute(
                          builder: (context) => SadPage(
                            list: [
                              {
                                'message5': preferences.getString('message5'),
                                'message6': preferences.getString('message6'),
                              }
                            ], // 空のリストを渡すか、適切なデータを渡す

                            index: 0, // 適切なインデックスを渡す
                            preferences: preferences,
                          ),
                      ),
                  ).then((updatedData) {
                    if (updatedData != null) {
                      setState(() {
                        // 編集後のデータを受け取り、状態を更新する
                        preferences.setString('message5', updatedData['message5']);
                        preferences.setString('message6', updatedData['message6']);
                      });
                    }
                  });
                },
                  child: Image.asset('images/sad.png', width: 100.0),
              ),
              GestureDetector(
                onTap: () {
                  readAloud4([
                    '${preferences.getString('message7').toString()}',
                    '${preferences.getString('message8').toString()}'
                  ]);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScarePage(
                            list: [
                              {
                                'message7': preferences.getString('message7'),
                                'message8': preferences.getString('message8'),
                              }
                            ], // 空のリストを渡すか、適切なデータを渡す

                            index: 0, // 適切なインデックスを渡す
                            preferences: preferences,
                          ),
                      ),
                  ).then((updatedData) {
                    if (updatedData != null) {
                      setState(() {
                        // 編集後のデータを受け取り、状態を更新する
                        preferences.setString('message7', updatedData['message7']);
                        preferences.setString('message8', updatedData['message8']);
                      });
                    }
                  });
                },
                  child: Image.asset('images/scare.png', width: 100.0),
              ),
              ElevatedButton(
                onPressed: () {
                  // 作成・変更画面への遷移の処理を追加
                },
                child: Text('作成・変更画面へ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> readAloud1(List<String> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final flutterTts = FlutterTts(); // MyApp クラスから新しいインスタンスを作成

    for (String messageKey in messages) {
      final messageText = prefs.getString(messageKey) ??
          ''; // メッセージが存在しない場合のデフォルト値を指定
      await flutterTts.setLanguage('ja-JP');
      await flutterTts.setSpeechRate(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.setVolume(1.0);
      await flutterTts.speak(messageText); // message ではなく messageText を使用
    }
  }
  Future<void> readAloud2(List<String> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final flutterTts = FlutterTts(); // MyApp クラスから新しいインスタンスを作成

    for (String messageKey in messages) {
      final messageText = prefs.getString(messageKey) ??
          ''; // メッセージが存在しない場合のデフォルト値を指定
      await flutterTts.setLanguage('ja-JP');
      await flutterTts.setSpeechRate(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.setVolume(1.0);
      await flutterTts.speak(messageText); // message ではなく messageText を使用
    }
  }
  Future<void> readAloud3(List<String> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final flutterTts = FlutterTts(); // MyApp クラスから新しいインスタンスを作成

    for (String messageKey in messages) {
      final messageText = prefs.getString(messageKey) ??
          ''; // メッセージが存在しない場合のデフォルト値を指定
      await flutterTts.setLanguage('ja-JP');
      await flutterTts.setSpeechRate(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.setVolume(1.0);
      await flutterTts.speak(messageText); // message ではなく messageText を使用
    }
  }
  Future<void> readAloud4(List<String> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final flutterTts = FlutterTts(); // MyApp クラスから新しいインスタンスを作成

    for (String messageKey in messages) {
      final messageText = prefs.getString(messageKey) ??
          ''; // メッセージが存在しない場合のデフォルト値を指定
      await flutterTts.setLanguage('ja-JP');
      await flutterTts.setSpeechRate(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.setVolume(1.0);
      await flutterTts.speak(messageText); // message ではなく messageText を使用
    }
  }
}
class AngryPage extends StatefulWidget {
  List list;
  int index;
  final SharedPreferences preferences; // 追加



  AngryPage(
      {required this.list, required this.index, required this.preferences});

  @override
  _AngryPageState createState() => _AngryPageState();
}
class _AngryPageState extends State<AngryPage> {
  bool isLoading = false;
  late Future<SharedPreferences> preferences; // Future<SharedPreferences> として宣言

  @override
  void initState() {
    super.initState();
    preferences = SharedPreferences.getInstance(); // Future を代入
  }
  Future<void> initializeData() async {

    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    setState(() {
      isLoading = false;
      // 編集後のデータを受け取り、状態を更新する
      if (widget.updatedData != null) {
        preferences.setString('message1', widget.updatedData!['message1']);
        preferences.setString('message2', widget.updatedData!['message2']);

      }

    });
  }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: FutureBuilder<SharedPreferences>(
          future: preferences,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Future が完了した場合、snapshot.data を使用して SharedPreferences オブジェクトにアクセス
              final sharedPreferences = snapshot.data;
              if (sharedPreferences != null) {
                return Container(
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
                            if ('${preferences.getString('message1')
                                .toString()}' !=
                                null)
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('${preferences.getString('message1')
                                    .toString()}'),
                              ),
                            Image.asset('images/angry.png', width: 30),
                            if ('${preferences.getString('message2')
                                .toString()}' !=
                                null)
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('${preferences.getString('message2')
                                    .toString()}'),
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
                );
              }
            }
          }
        ),
      );
    }
  }
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

  _PainPageState() {
    SharedPreferences.getInstance().then((sharedPreferences) {
      preferences = sharedPreferences;
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
                    if ('${preferences.getString('message1').toString()}' != null)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${preferences.getString('message1').toString()}'),
                      ),
                    Image.asset('images/angry.png', width: 30),
                    if ('${preferences.getString('message2').toString()}' != null)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${preferences.getString('message2').toString()}'),
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
class SadPage extends StatefulWidget {
  List list;
  int index;
  final SharedPreferences preferences; // 追加



  SadPage(
      {required this.list, required this.index, required this.preferences});

  @override
  _SadPageState createState() => _SadPageState();
}
class _SadPageState extends State<SadPage> {
  bool isLoading = false;
  late SharedPreferences preferences; // ここで preferences フィールドを宣言
  
  _ScarePageState() {
    SharedPreferences.getInstance().then((sharedPreferences) {
      preferences = sharedPreferences;
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
                    if ('${preferences.getString('message1').toString()}' != null)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${preferences.getString('message1').toString()}'),
                      ),
                    Image.asset('images/angry.png', width: 30),
                    if ('${preferences.getString('message2').toString()}' != null)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${preferences.getString('message2').toString()}'),
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
class ScarePage extends StatefulWidget {
  List list;
  int index;
  final SharedPreferences preferences; // 追加



  ScarePage(
      {required this.list, required this.index, required this.preferences});

  @override
  _ScarePageState createState() => _ScarePageState();
}
class _ScarePageState extends State<ScarePage> {
  bool isLoading = false;
  late SharedPreferences preferences; // ここで preferences フィールドを宣言

  _PageState() {
    SharedPreferences.getInstance().then((sharedPreferences) {
      preferences = sharedPreferences;
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
                    if ('${preferences.getString('message1').toString()}' != null)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${preferences.getString('message1').toString()}'),
                      ),
                    Image.asset('images/angry.png', width: 30),
                    if ('${preferences.getString('message2').toString()}' != null)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${preferences.getString('message2').toString()}'),
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


class _EditDataState extends State<EditData> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  bool isLoading = false;
  late SharedPreferences preferences; // 追加


  TextEditingController message1Controller = TextEditingController();
  TextEditingController message2Controller = TextEditingController();
  TextEditingController message3Controller = TextEditingController();
  TextEditingController message4Controller = TextEditingController();
  TextEditingController message5Controller = TextEditingController();
  TextEditingController message6Controller = TextEditingController();
  TextEditingController message7Controller = TextEditingController();
  TextEditingController message8Controller = TextEditingController();


  @override
  void initState() {
    preferences = widget.preferences; // 追加
    message1Controller = TextEditingController(text: widget.list[widget.index]['message1']);
    message2Controller = TextEditingController(text: widget.list[widget.index]['message2']);
    message3Controller = TextEditingController(text: widget.list[widget.index]['message3']);
    message4Controller = TextEditingController(text: widget.list[widget.index]['message4']);
    message5Controller = TextEditingController(text: widget.list[widget.index]['message5']);
    message6Controller = TextEditingController(text: widget.list[widget.index]['message6']);
    message7Controller = TextEditingController(text: widget.list[widget.index]['message7']);
    message8Controller = TextEditingController(text: widget.list[widget.index]['message8']);

    super.initState();
  }

  void loadUserData() {
    message1Controller.text = widget.preferences.getString('message1') ?? '';
    message2Controller.text = widget.preferences.getString('message2') ?? '';
    message3Controller.text = widget.preferences.getString('message3') ?? '';
    message4Controller.text = widget.preferences.getString('message4') ?? '';
    message5Controller.text = widget.preferences.getString('message5') ?? '';
    message6Controller.text = widget.preferences.getString('message6') ?? '';
    message7Controller.text = widget.preferences.getString('message7') ?? '';
    message8Controller.text = widget.preferences.getString('message8') ?? '';
  }

  void saveUserData() {
    setState(() {
      preferences.setString('message1', message1Controller.text);
      preferences.setString('message2', message2Controller.text);
      preferences.setString('message3', message3Controller.text);
      preferences.setString('message4', message4Controller.text);
      preferences.setString('message5', message5Controller.text);
      preferences.setString('message6', message6Controller.text);
      preferences.setString('message7', message7Controller.text);
      preferences.setString('message8', message8Controller.text);


    });

    Navigator.pop(context, {
      'message1': message1Controller.text,
      'message2': message2Controller.text,
      'message3': message3Controller.text,
      'message4': message4Controller.text,
      'message5': message5Controller.text,
      'message6': message6Controller.text,
      'message7': message7Controller.text,
      'message8': message8Controller.text,
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.center,

              ),


              SizedBox(height: 10),
              // ユーザー情報編集画面に移動するボタンを追加
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditData(
                              list: [
                                {
                                  'id': preferences.getInt('id'),
                                  // getInt('id')の結果をそのまま代入
                                  'message1': preferences.getString('message1'),
                                  'message2': preferences.getString('message2'),
                                  'message3': preferences.getString('message3'),
                                  'message4': preferences.getString('message4'),
                                  'message5': preferences.getString('message5'),
                                  'message6': preferences.getString('message6'),
                                  'message7': preferences.getString('message7'),
                                  'message8': preferences.getString('message8'),
                                }
                              ], // 空のリストを渡すか、適切なデータを渡す

                              index: 0, // 適切なインデックスを渡す
                              preferences: preferences,
                            ),
                      ),
                    ).then((updatedData) {
                      if (updatedData != null) {
                        setState(() {
                          // 編集後のデータを受け取り、状態を更新する
                          preferences.setString(
                              'message1', updatedData['message1']);
                          preferences.setString(
                              'message2', updatedData['message2']);
                          preferences.setString(
                              'message3', updatedData['message3']);
                          preferences.setString(
                              'message4', updatedData['message4']);
                          preferences.setString(
                              'message5', updatedData['message5']);
                          preferences.setString(
                              'message6', updatedData['message6']);
                          preferences.setString(
                              'message7', updatedData['message7']);
                          preferences.setString(
                              'message8', updatedData['message8']);
                        });
                      }
                    });
                  },
                  child: Text('メッセージを編集or作成'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}













