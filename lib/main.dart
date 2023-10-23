import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_request/view/dashboard.dart';
import 'package:my_request/view/login.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:my_request/screens/home.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 初期化を追加

  final FlutterTts flutterTts = FlutterTts();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final String title = '';
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String>(
        future: _getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Some error has Occurred');
          } else if (snapshot.hasData && snapshot.data != null) {
            final token = snapshot.data;
            if (token != null && token.isNotEmpty) {
              return Home();
            } else {
              return Login();
            }
          } else {
            return Login();
          }
        },
      ),
    );
  }

  Future<String> _getToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
