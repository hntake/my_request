import 'package:flutter/material.dart';
import 'package:my_request/view/angry.dart';
import 'package:my_request/view/pain.dart';
import 'package:my_request/view/sad.dart';
import 'package:my_request/view/scare.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:my_request/view/login.dart';
import 'package:my_request/methods/api.dart';
import 'package:my_request/Controllers/databasehelper.dart';
import 'package:my_request/view/dashboard.dart';
import 'package:my_request/helper/constant.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';



class Home extends StatelessWidget {
  final Map<String, dynamic>? updatedData; // 追加
  final Map<String, dynamic>? modeData; // 追加
  const Home({Key? key, this.updatedData, this.modeData}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // SharedPreferencesのインスタンスを初期化
    late SharedPreferences preferences;
    // SharedPreferencesを初期化する非同期関数を呼び出す
    void initializePreferences() async {
      preferences = await SharedPreferences.getInstance();
      final flutterTts = FlutterTts(); // MyApp クラスから新しいインスタンスを作成

        await flutterTts.setLanguage("ja-JP");
      await flutterTts.setSpeechRate(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.setVolume(1.0);
    }
  


      // initializePreferencesを呼び出して'preferences'を初期化
      initializePreferences();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue, // アプリバーの背景色を青色に変更
          title: Text('ホーム'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AngryPage(
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
                  );
                },
                child: Image.asset('images/angry.png', width: 100.0),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PainPage(
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
                  );
                },
                child: Image.asset('images/pain.png', width: 100.0),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SadPage(
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
                  );
                },
                child: Image.asset('images/sad.png', width: 100.0),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ScarePage(
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
                  );
                },
                child: Image.asset('images/scare.png', width: 100.0),
              ),
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
                        // 編集後のデータを受け取り、状態を更新する
                        preferences.setString('message1',
                            updatedData['message1']);
                        preferences.setString('message2',
                            updatedData['message2']);
                        preferences.setString('message3',
                            updatedData['message3']);
                        preferences.setString('message4',
                            updatedData['message4']);
                        preferences.setString('message5',
                            updatedData['message5']);
                        preferences.setString('message6',
                            updatedData['message6']);
                        preferences.setString('message7',
                            updatedData['message7']);
                        preferences.setString('message8',
                            updatedData['message8']);
                      }
                    });
                  },
                  child: Text('メッセージを作成・編集　create or update messages'),
                ),
              ),
            ],
          ),
        ),
      );
    }
  } //widget
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

  class AngryPage extends StatefulWidget {
    List list;
    int index;
    final SharedPreferences preferences; // 追加
    final Map<String, dynamic>? updatedData; // 追加

  AngryPage({
    required this.preferences,
    this.list = const [],
    this.index = 0,
    this.updatedData, // 追加
  
    });

  @override
    _AngryPageState createState() => _AngryPageState();
    }
  class _AngryPageState extends State<AngryPage> {
    bool isLoading = false;
    late SharedPreferences preferences; // SharedPreferences オブジェクトとして宣言

    @override
    void initState() {
      super.initState();
      _loadData();
      // Future<SharedPreferences> を取得して SharedPreferences オブジェクトに代入
      SharedPreferences.getInstance().then((prefs) {
        setState(() {
          preferences = prefs;
        });
      });
    }

    Future<void> _loadData() async {
      try {
        final preferences = await SharedPreferences
            .getInstance(); // <-- Get SharedPreferences instance
        setState(() {
          isLoading = false;
          // 編集後のデータを受け取り、状態を更新する
          if (widget.updatedData != null) {
            preferences.setString('message1', widget.updatedData!['message1']);
            preferences.setString('message2', widget.updatedData!['message2']);
          }
        });
      } catch (e) {
        // エラーハンドリング: データの読み込み中にエラーが発生
        print('データの読み込みエラー: $e');
        // その他のエラーハンドリング処理
      }

  }
    Future<void> readAloud1(
        {List<String> messages = const ['message1', 'message2']}) async {
      try {
        final prefs = await SharedPreferences.getInstance();


        for (String messageKey in messages) {
          final messageText = prefs.getString(messageKey) ?? '';
          print('Reading message: messageText'); // メッセージをデバッグ出力

          // メッセージが存在しない場合のデフォルト値を指定
          final flutterTts = FlutterTts(); // MyApp クラスから新しいインスタンスを作成
          if (isJapanese(messageText)) {
            await flutterTts.setLanguage("ja-JP");
          } else {
            await flutterTts.setLanguage("en-US");
          }
          await flutterTts.setSpeechRate(1.0);
          await flutterTts.setPitch(1.0);
          await flutterTts.setVolume(1.0);
          // テキスト読み上げを遅延させる（例: 3秒間遅延）
          await Future.delayed(Duration(seconds: 3));

          await flutterTts.speak(messageText);
        }
      } catch (e) {
        // エラーハンドリング: データの読み込み中にエラーが発生
        print('データの読み込みエラー: $e');
        // その他のエラーハンドリング処理
      }
    }
    bool isJapanese(String messageText) {
      // 1. テキストを文字単位でループ
      for (int i = 0; i < messageText.length; i++) {
        // 2. テキスト内の各文字をUnicodeコードポイントに変換
        int codePoint = messageText.codeUnitAt(i);

        // 3. Unicodeコードポイントが日本語の文字範囲に含まれるかを確認
        //    日本語の文字範囲は、通常、U+3040 から U+30FF の範囲です。
        //    ただし、これにはカタカナも含まれます。
        if (codePoint >= 0x3040 && codePoint <= 0x30FF) {
          // 4. 日本語文字が見つかった場合、テキストは日本語とみなす
          return true;
        }
      }
      // 5. ループが終了しても日本語文字が見つからない場合、テキストは日本語ではないとみなす
      return false;
    }

    

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            final preferences = snapshot.data;
            return Center(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          if (preferences != null && preferences.getString(
                              'message1') != null)
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                preferences.getString('message1')!,
                                style: GoogleFonts.notoSerif(
                                  fontSize: 50,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          Image.asset('images/angry.png', width: 200),
                          if (preferences != null && preferences.getString(
                              'message2') != null)
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                preferences.getString('message2')!,
                                style: GoogleFonts.notoSerif(
                                  fontSize: 50,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                        ],
                      ),

                    ),

                    Padding(
                      padding: EdgeInsets.all(16.0),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // ボタンがクリックされたときにreadAloud1メソッドを呼び出す
                        readAloud1(); // メッセージのキーをリストとして渡す
                      },
                      child: Image.asset('images/ear.png', width: 100),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // ボタンがクリックされたときの処理をここに追加
                        // 例: ページを戻る
                        Navigator.of(context).pop();
                      },
                      child: Image.asset('images/left-arrow.png', width: 100),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
    class PainPage extends StatefulWidget {
  List list;
  int index;
  final SharedPreferences preferences; // 追加
  final Map<String, dynamic>? updatedData; // 追加

  PainPage({
    required this.preferences,
    this.list = const [],
    this.index = 0,
    this.updatedData, // 追加

  });

  @override
  _PainPageState createState() => _PainPageState();
}
class _PainPageState extends State<PainPage> {
  bool isLoading = false;
  late SharedPreferences preferences; // SharedPreferences オブジェクトとして宣言

  @override
  void initState() {
    super.initState();
    _loadData();
    // Future<SharedPreferences> を取得して SharedPreferences オブジェクトに代入
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        preferences = prefs;
      });
    });
  }
  Future<void> _loadData() async {
    try{
      final preferences = await SharedPreferences.getInstance(); // <-- Get SharedPreferences instance
      setState(() {
        isLoading = false;
        // 編集後のデータを受け取り、状態を更新する
        if (widget.updatedData != null) {
          preferences.setString('message3', widget.updatedData!['message3']);
          preferences.setString('message4', widget.updatedData!['message4']);
        }
      });
    } catch (e) {
      // エラーハンドリング: データの読み込み中にエラーが発生
      print('データの読み込みエラー: $e');
      // その他のエラーハンドリング処理
    }
  }
  Future<void> readAloud1({List<String> messages = const ['message3', 'message4']}) async {
    try{
      final prefs = await SharedPreferences.getInstance();


      for (String messageKey in messages) {
        final messageText = prefs.getString(messageKey) ?? '';
        print('Reading message: $messageText'); // メッセージをデバッグ出力

        // メッセージが存在しない場合のデフォルト値を指定
        final flutterTts = FlutterTts(); // MyApp クラスから新しいインスタンスを作成
        if (isJapanese(messageKey)) {
          await flutterTts.setLanguage("ja-JP");
        } else {
          await flutterTts.setLanguage("en-US");
        }
        await flutterTts.setSpeechRate(1.0);
        await flutterTts.setPitch(1.0);
        await flutterTts.setVolume(1.0);
        // テキスト読み上げを遅延させる（例: 3秒間遅延）
        await Future.delayed(Duration(seconds: 3));

        await flutterTts.speak(messageText);
      } } catch (e) {
      // エラーハンドリング: データの読み込み中にエラーが発生
      print('データの読み込みエラー: $e');
      // その他のエラーハンドリング処理
    }
  }
  bool isJapanese(String messageKey) {
    // 1. テキストを文字単位でループ
    for (int i = 0; i < messageKey.length; i++) {
      // 2. テキスト内の各文字をUnicodeコードポイントに変換
      int codePoint = messageKey.codeUnitAt(i);

      // 3. Unicodeコードポイントが日本語の文字範囲に含まれるかを確認
      //    日本語の文字範囲は、通常、U+3040 から U+30FF の範囲です。
      //    ただし、これにはカタカナも含まれます。
      if (codePoint >= 0x3040 && codePoint <= 0x30FF) {
        // 4. 日本語文字が見つかった場合、テキストは日本語とみなす
        return true;
      }
    }
    // 5. ループが終了しても日本語文字が見つからない場合、テキストは日本語ではないとみなす
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(), // SharedPreferencesのインスタンスを非同期で取得
            builder: (context, snapshot) {
              final sharedPreferences = snapshot.data;
              return Center(
                  child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(

                      child: Column(
                        children: <Widget>[
                          if ('${preferences.getString('message3')
                              .toString()}' !=
                              null)
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                preferences.getString('message3')!,
                                style: GoogleFonts.notoSerif(
                                  fontSize: 50,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          Image.asset('images/pain.png', width: 200),
                          if ('${preferences.getString('message4')
                              .toString()}' !=
                              null)
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                preferences.getString('message4')!,
                                style: GoogleFonts.notoSerif(
                                  fontSize: 50,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                    padding: EdgeInsets.all(8.0),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // ボタンがクリックされたときにreadAloud1メソッドを呼び出す
                        readAloud1(); // メッセージのキーをリストとして渡す

                      },
                      child: Image.asset('images/ear.png', width: 100),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // ボタンがクリックされたときの処理をここに追加
                        // 例: ページを戻る
                        Navigator.of(context).pop();
                      },
                      child: Image.asset('images/left-arrow.png', width: 100),
                    ),
                  ],
                ),
                  ),
              );
            },
        ),
    );
  }
}
class SadPage extends StatefulWidget {
  List list;
  int index;
  final SharedPreferences preferences; // 追加
  final Map<String, dynamic>? updatedData; // 追加

  SadPage({
    required this.preferences,
    this.list = const [],
    this.index = 0,
    this.updatedData, // 追加

  });

  @override
  _SadPageState createState() => _SadPageState();
}
class _SadPageState extends State<SadPage> {
  bool isLoading = false;
  late SharedPreferences preferences; // SharedPreferences オブジェクトとして宣言

  @override
  void initState() {
    super.initState();
    _loadData();
    // Future<SharedPreferences> を取得して SharedPreferences オブジェクトに代入
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        preferences = prefs;
      });
    });
  }
  Future<void> _loadData() async {
    try{
      final preferences = await SharedPreferences.getInstance(); // <-- Get SharedPreferences instance
      setState(() {
        isLoading = false;
        // 編集後のデータを受け取り、状態を更新する
        if (widget.updatedData != null) {
          preferences.setString('message5', widget.updatedData!['message5']);
          preferences.setString('message6', widget.updatedData!['message6']);
        }
      });
    } catch (e) {
      // エラーハンドリング: データの読み込み中にエラーが発生
      print('データの読み込みエラー: $e');
      // その他のエラーハンドリング処理
    }
  }
  Future<void> readAloud1({List<String> messages = const ['message5', 'message6']}) async {
    try{
      final prefs = await SharedPreferences.getInstance();


      for (String messageKey in messages) {
        final messageText = prefs.getString(messageKey) ?? '';
        print('Reading message: $messageText'); // メッセージをデバッグ出力

        // メッセージが存在しない場合のデフォルト値を指定
        final flutterTts = FlutterTts(); // MyApp クラスから新しいインスタンスを作成
        if (isJapanese(messageKey)) {
          await flutterTts.setLanguage("ja-JP");
        } else {
          await flutterTts.setLanguage("en-US");
        }
        await flutterTts.setSpeechRate(1.0);
        await flutterTts.setPitch(1.0);
        await flutterTts.setVolume(1.0);
        // テキスト読み上げを遅延させる（例: 3秒間遅延）
        await Future.delayed(Duration(seconds: 3));

        await flutterTts.speak(messageText);
      } } catch (e) {
      // エラーハンドリング: データの読み込み中にエラーが発生
      print('データの読み込みエラー: $e');
      // その他のエラーハンドリング処理
    }
  }
  bool isJapanese(String messageKey) {
    // 1. テキストを文字単位でループ
    for (int i = 0; i < messageKey.length; i++) {
      // 2. テキスト内の各文字をUnicodeコードポイントに変換
      int codePoint = messageKey.codeUnitAt(i);

      // 3. Unicodeコードポイントが日本語の文字範囲に含まれるかを確認
      //    日本語の文字範囲は、通常、U+3040 から U+30FF の範囲です。
      //    ただし、これにはカタカナも含まれます。
      if (codePoint >= 0x3040 && codePoint <= 0x30FF) {
        // 4. 日本語文字が見つかった場合、テキストは日本語とみなす
        return true;
      }
    }
    // 5. ループが終了しても日本語文字が見つからない場合、テキストは日本語ではないとみなす
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(), // SharedPreferencesのインスタンスを非同期で取得
            builder: (context, snapshot) {
              final sharedPreferences = snapshot.data;
              return Center(
                  child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(

                      child: Column(
                        children: <Widget>[
                          if ('${preferences.getString('message5')
                              .toString()}' !=
                              null)
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                preferences.getString('message5')!,
                                style: GoogleFonts.notoSerif(
                                  fontSize: 50,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          Image.asset('images/sad.png', width: 200),
                          if ('${preferences.getString('message6')
                              .toString()}' !=
                              null)
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                preferences.getString('message6')!,
                                style: GoogleFonts.notoSerif(
                                  fontSize: 50,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // ボタンがクリックされたときにreadAloud1メソッドを呼び出す
                        readAloud1(); // メッセージのキーをリストとして渡す

                      },
                      child: Image.asset('images/ear.png', width: 100),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // ボタンがクリックされたときの処理をここに追加
                        // 例: ページを戻る
                        Navigator.of(context).pop();
                      },
                      child: Image.asset('images/left-arrow.png', width: 100),
                    ),
                  ],
                ),
                  ),
              );
            },
        ),
    );
  }
}
class ScarePage extends StatefulWidget {
  List list;
  int index;
  final SharedPreferences preferences; // 追加
  final Map<String, dynamic>? updatedData; // 追加

  ScarePage({
    required this.preferences,
    this.list = const [],
    this.index = 0,
    this.updatedData, // 追加

  });

  @override
  _ScarePageState createState() => _ScarePageState();
}
class _ScarePageState extends State<ScarePage> {
  bool isLoading = false;
  late SharedPreferences preferences; // SharedPreferences オブジェクトとして宣言

  @override
  void initState() {
    super.initState();
    _loadData();
    // Future<SharedPreferences> を取得して SharedPreferences オブジェクトに代入
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        preferences = prefs;
      });
    });
  }
  Future<void> _loadData() async {
    try{
      final preferences = await SharedPreferences.getInstance(); // <-- Get SharedPreferences instance
      setState(() {
        isLoading = false;
        // 編集後のデータを受け取り、状態を更新する
        if (widget.updatedData != null) {
          preferences.setString('message7', widget.updatedData!['message7']);
          preferences.setString('message8', widget.updatedData!['message8']);
        }
      });
    } catch (e) {
      // エラーハンドリング: データの読み込み中にエラーが発生
      print('データの読み込みエラー: $e');
      // その他のエラーハンドリング処理
    }
  }
  Future<void> readAloud1({List<String> messages = const ['message7', 'message8']}) async {
    try{
      final prefs = await SharedPreferences.getInstance();


      for (String messageKey in messages) {
        final messageText = prefs.getString(messageKey) ?? '';
        print('Reading message: $messageText'); // メッセージをデバッグ出力

        // メッセージが存在しない場合のデフォルト値を指定
        final flutterTts = FlutterTts(); // MyApp クラスから新しいインスタンスを作成
        if (isJapanese(messageKey)) {
          await flutterTts.setLanguage("ja-JP");
        } else {
          await flutterTts.setLanguage("en-US");
        }
        await flutterTts.setSpeechRate(1.0);
        await flutterTts.setPitch(1.0);
        await flutterTts.setVolume(1.0);
        // テキスト読み上げを遅延させる（例: 3秒間遅延）
        await Future.delayed(Duration(seconds: 3));

        await flutterTts.speak(messageText);
      } } catch (e) {
      // エラーハンドリング: データの読み込み中にエラーが発生
      print('データの読み込みエラー: $e');
      // その他のエラーハンドリング処理
    }
  }
  bool isJapanese(String messageKey) {
    // 1. テキストを文字単位でループ
    for (int i = 0; i < messageKey.length; i++) {
      // 2. テキスト内の各文字をUnicodeコードポイントに変換
      int codePoint = messageKey.codeUnitAt(i);

      // 3. Unicodeコードポイントが日本語の文字範囲に含まれるかを確認
      //    日本語の文字範囲は、通常、U+3040 から U+30FF の範囲です。
      //    ただし、これにはカタカナも含まれます。
      if (codePoint >= 0x3040 && codePoint <= 0x30FF) {
        // 4. 日本語文字が見つかった場合、テキストは日本語とみなす
        return true;
      }
    }
    // 5. ループが終了しても日本語文字が見つからない場合、テキストは日本語ではないとみなす
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(), // SharedPreferencesのインスタンスを非同期で取得
            builder: (context, snapshot) {
              final sharedPreferences = snapshot.data;
              return Center(
                  child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                  
                      child: Column(
                        children: <Widget>[
                          if ('${preferences.getString('message7')
                              .toString()}' !=
                              null)
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                preferences.getString('message7')!,
                                style: GoogleFonts.notoSerif(
                                  fontSize: 50,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          Image.asset('images/scare.png', width: 200),
                          if ('${preferences.getString('message8')
                              .toString()}' !=
                              null)
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                preferences.getString('message8')!,
                                style: GoogleFonts.notoSerif(
                                  fontSize: 50,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // ボタンがクリックされたときにreadAloud1メソッドを呼び出す
                        readAloud1(); // メッセージのキーをリストとして渡す

                      },
                      child: Image.asset('images/ear.png', width: 100),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // ボタンがクリックされたときの処理をここに追加
                        // 例: ページを戻る
                        Navigator.of(context).pop();
                      },
                      child: Image.asset('images/left-arrow.png', width: 100),
                    ),
                  ],
                ),
                  ),
              );
            },
        ),
    );
  }
}
// ユーザー情報編集画面
class _EditDataState extends State<EditData> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
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
      appBar: AppBar(
        title: Text('作成・編集 create or update'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'message1',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: message1Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'message2',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: message2Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'message3',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: message3Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'message4',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: message4Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'message5',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: message5Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'message6',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: message6Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'message7',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: message7Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'message8',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: message8Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  Future<void> updateData() async {
                    int userId = widget.list[widget.index]['id'] ?? 0;
                    String idValue = userId.toString();
                    if (userId != null) {
                      final data = {
                        'id': userId.toString(),
                        'message1': message1Controller.text.trim(),
                        'message2': message2Controller.text.trim(),
                        'message3': message3Controller.text.trim(),
                        'message4': message4Controller.text.trim(),
                        'message5': message5Controller.text.trim(),
                        'message6': message6Controller.text.trim(),
                        'message7': message7Controller.text.trim(),
                        'message8': message8Controller.text.trim(),
                      };
                      final Map<String, String> requestData = data.map((key,
                          value) => MapEntry(key, value.toString()));

                      final result = await API().putRequest(
                        route: '/api/update_user_fl/$userId', data: requestData,
                      );
                      setState(() {
                        preferences.setString('message1',
                            message1Controller.text);
                        preferences.setString('message2',
                            message2Controller.text);
                        preferences.setString('message3',
                            message3Controller.text);
                        preferences.setString('message4',
                            message4Controller.text);
                        preferences.setString('message5',
                            message5Controller.text);
                        preferences.setString('message6',
                            message6Controller.text);
                        preferences.setString('message7',
                            message7Controller.text);
                        preferences.setString('message8',
                            message8Controller.text);
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
                    } else {
                      return print('Some error has Occurred');
                    }
                  }
                  // 呼び出し元のコード内でupdateData()を呼び出す
                  updateData();
                },
                child: Text('変更内容を送信 send'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
