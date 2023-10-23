import 'package:my_request/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_request/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences preferences;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    setState(() {
      isLoading = false;

    });
  }

  void logout() {
    preferences.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Login(),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                logout();
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.red,
                  child: Text(
                    'logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'id',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${preferences.getInt('id').toString()}',
                      ),
                      SizedBox(height: 20),
                      Text(
                        '名前',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${preferences.getString('name').toString()}',
                      ),
                      SizedBox(height: 20),
                      Text(
                        'メールアドレス',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${preferences.getString('email').toString()}',
                      ),
                      SizedBox(height: 20),
                      Text(
                        '連絡先①',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${preferences.getString('tel1').toString()}',
                      ),
                      SizedBox(height: 20),
                      Text(
                        '連絡先②',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${preferences.getString('tel2').toString()}',
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(child: Text('曜日')),
                      TableCell(child: Text('朝6～12時')),
                      TableCell(child: Text('昼12~19時')),
                      TableCell(child: Text('夜19～6時')),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Text('月曜日')),
                      TableCell(child: Text('mon1: ${preferences.getInt(
                          'mon1')}' == 0 ? '連絡先①' : '連絡先②')),
                      TableCell(child: Text('mon2: ${preferences.getInt(
                          'mon2')}' == 0 ? '連絡先①' : '連絡先②')),
                      TableCell(child: Text('mon3: ${preferences.getInt(
                          'mon3')}' == 0 ? '連絡先①' : '連絡先②')),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Text('火曜日')),
                      TableCell(child: Text('mon1: ${preferences.getInt(
                          'mon1')}' == 0 ? '連絡先①' : '連絡先②')),
                      TableCell(child: Text('mon2: ${preferences.getInt(
                          'mon2')}' == 0 ? '連絡先①' : '連絡先②')),
                      TableCell(child: Text('mon3: ${preferences.getInt(
                          'mon3')}' == 0 ? '連絡先①' : '連絡先②')),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Text('水曜日')),
                      TableCell(child: Text('mon1: ${preferences.getInt(
                          'mon1')}' == 0 ? '連絡先①' : '連絡先②')),
                      TableCell(child: Text('mon2: ${preferences.getInt(
                          'mon2')}' == 0 ? '連絡先①' : '連絡先②')),
                      TableCell(child: Text('mon3: ${preferences.getInt(
                          'mon3')}' == 0 ? '連絡先①' : '連絡先②')),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Text('木曜日')),
                      TableCell(child: Text('mon1: ${preferences.getInt(
                          'mon1')}' == 0 ? '連絡先①' : '連絡先②')),
                      TableCell(child: Text('mon2: ${preferences.getInt(
                          'mon2')}' == 0 ? '連絡先①' : '連絡先②')),
                      TableCell(child: Text('mon3: ${preferences.getInt(
                          'mon3')}' == 0 ? '連絡先①' : '連絡先②')),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Text('金曜日')),
                      TableCell(child: Text('mon1: ${preferences.getInt(
                          'mon1')}' == 0 ? '連絡先①' : '連絡先②')),
                      TableCell(child: Text('mon2: ${preferences.getInt(
                          'mon2')}' == 0 ? '連絡先①' : '連絡先②')),
                      TableCell(child: Text('mon3: ${preferences.getInt(
                          'mon3')}' == 0 ? '連絡先①' : '連絡先②')),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Text('土曜日')),
                      TableCell(child: Text('mon1: ${preferences.getInt(
                          'mon1')}' == 0 ? '連絡先①' : '連絡先②')),
                      TableCell(child: Text('mon2: ${preferences.getInt(
                          'mon2')}' == 0 ? '連絡先①' : '連絡先②')),
                      TableCell(child: Text('mon3: ${preferences.getInt(
                          'mon3')}' == 0 ? '連絡先①' : '連絡先②')),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Text('日曜日')),
                      TableCell(child: Text('mon1: ${preferences.getInt(
                          'mon1')}' == 0 ? '連絡先①' : '連絡先②')),
                      TableCell(child: Text('mon2: ${preferences.getInt(
                          'mon2')}' == 0 ? '連絡先①' : '連絡先②')),
                      TableCell(child: Text('mon3: ${preferences.getInt(
                          'mon3')}' == 0 ? '連絡先①' : '連絡先②')),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // ユーザー情報編集画面に移動するボタンを追加

          ],
        ),
      ),
    );
  }
}
