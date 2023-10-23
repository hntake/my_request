import 'package:flutter/material.dart';
import 'package:my_request/Controllers/databasehelper.dart';
import 'package:my_request/view/login.dart';
import 'package:my_request/view/showdata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';




class Dashboard extends StatefulWidget{

  final String title;

  Dashboard({Key? key, required this.title}) : super(key: key);

  @override
  DashboardState  createState() => DashboardState();
}


class DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    initializePreferences();
  }

  Future<void> initializePreferences() async {
    preferences = await SharedPreferences.getInstance();
  }


  DatabaseHelper databaseHelper = new DatabaseHelper();
  late SharedPreferences preferences;

  get title => null;



  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Dashboard',
      home: Scaffold(
          appBar: AppBar(
            title:  Text('Dashboard'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.cancel),
                onPressed: (){
                  _save('0');
                  Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new Login(),
                      )
                  );
                },
              )
            ],
          ),
        body: Center(
          child: ElevatedButton(
            child: Text('Go to LoginPage'),
            onPressed: () {
              _save('0');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => Login(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
















