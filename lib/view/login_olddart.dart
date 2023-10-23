import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_request/helper/constant.dart';
import 'package:my_request/screens/home.dart';
import 'package:my_request/widget/input_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


import 'package:my_request/methods/api.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isLoading = false;

  Future<void> saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', token);
  }
  Future<void> saveLoginInfo() async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'email', value: email.text.toString());
    await storage.write(key: 'password', value: password.text.toString());
  }
  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    final data = {
      'email': email.text.toString(),
      'password': password.text.toString(),
    };
    final result = await API().postRequest(route: '/api/login', data: data);
    final response = jsonDecode(result.body);
    final String? message1 = response['feel']['message1'];
    final String? message2 = response['feel']['message2'];
    final String? message3 = response['feel']['message3'];
    final String? message4 = response['feel']['message4'];
    final String? message5 = response['feel']['message5'];
    final String? message6 = response['feel']['message6'];
    final String? message7 = response['feel']['message7'];
    final String? message8 = response['feel']['message8'];

// ヌルチェックと代替値の設定
    final String defaultMessage = "";
    final message1Value = message1 ?? defaultMessage;
    final message2Value = message2 ?? defaultMessage;
    final message3Value = message3 ?? defaultMessage;
    final message4Value = message4 ?? defaultMessage;
    final message5Value = message5 ?? defaultMessage;
    final message6Value = message6 ?? defaultMessage;
    final message7Value = message7 ?? defaultMessage;
    final message8Value = message8 ?? defaultMessage;


// 代替値を使ってデータを保存
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('message1', message1Value);
    await preferences.setString('message2', message2Value);
    await preferences.setString('message3', message3Value);
    await preferences.setString('message4', message4Value);
    await preferences.setString('message5', message5Value);
    await preferences.setString('message6', message6Value);
    await preferences.setString('message7', message7Value);
    await preferences.setString('message8', message8Value);


    if (response['status'] == 200) {
      await saveLoginInfo();
      // トークンを保存
      String token = response['token'];
      await saveToken(token);

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('message1', response['feel']['message1']);
      await preferences.setString('message2', response['feel']['message2']);
      await preferences.setString('message3', response['feel']['message3']);
      await preferences.setString('message4', response['feel']['message4']);
      await preferences.setString('message5', response['feel']['message5']);
      await preferences.setString('message6', response['feel']['message6']);
      await preferences.setString('message7', response['feel']['message7']);
      await preferences.setString('message8', response['feel']['message8']);



      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadLoginInfo(); // ログイン情報を読み込む
  }

  // 保存されたメールアドレスとパスワードを読み込んで、テキストフィールドに設定する
  void loadLoginInfo() async {
    final storage = FlutterSecureStorage();
    String? savedEmail = await storage.read(key: 'email');
    String? savedPassword = await storage.read(key: 'password');
    if (savedEmail != null && savedPassword != null) {
      email.text = savedEmail;
      password.text = savedPassword;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              primaryColor,
              secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spancer(h: height * 0.1),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    spancer(
                      w: width * 0.05,
                    ),
                    Container(
                      width: width * 0.5,
                      child: const Text(
                        'マイリク - my request',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                spancer(
                  h: height * 0.15,
                ),
                InputField(
                  width: width,
                  controller: email,
                  hintText: 'メールアドレス',
                ),
                spancer(
                  h: height * 0.01,
                ),
                InputField(
                  width: width,
                  controller: password,
                  hintText: 'パスワード',
                  isObscure: true,
                ),
                spancer(
                  h: height * 0.03,
                ),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: InkWell(
                    onTap: () {
                      _launchURL2();
                    },
                    child: const Text(
                      'パスワードを忘れましたか？',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),

                spancer(
                  h: height * 0.1,
                ),
                InkWell(
                  onTap: () {
                    loginUser();
                  },
                  child: Container(
                    width: double.maxFinite,
                    alignment: Alignment.centerRight,
                    padding: spacing(
                      h: 20,
                    ),
                    child: Container(
                        width: width * 0.3,
                        padding: spacing(
                          h: 20,
                          v: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(width),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child:Text(
                                'ログイン',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_right_alt_rounded,
                              color: primaryColor,
                            )
                          ],
                        )
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Row(
                  children: [
                    Text(
                      'Your first time?',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 18,
                      ),
                    ),
                    spancer(w: 4),
                    InkWell(
                      onTap: () {
                        _launchURL();
                      },
                      child: const Text(
                        '新規登録はこちらから',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _launchURL() async {
  const url = 'https://itcha50.com/register';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
void _launchURL2() async {
  const url = 'https://itcha50.com/password/reset';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

