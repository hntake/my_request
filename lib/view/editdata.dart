import 'package:flutter/material.dart';
import 'package:my_request/Controllers/databasehelper.dart';
import 'package:my_request/view/dashboard.dart';
import '../../methods/api.dart';
import 'package:my_request/helper/constant.dart';
import 'package:my_request/view/login.dart';




class EditData extends StatefulWidget{
  List list;
  int index;

  EditData({required this.index, required this.list});


  @override
  EditDataState  createState() => EditDataState();
}

class EditDataState extends State<EditData> {
  DatabaseHelper databaseHelper = new DatabaseHelper();


  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _tel2Controller = TextEditingController();
  TextEditingController _tel1Controller = TextEditingController();


  @override
  void initState(){
    _nameController = TextEditingController(text: widget.list[widget.index]['name']);
    _emailController = TextEditingController(text: widget.list[widget.index]['email']);
    _tel1Controller = TextEditingController(text: widget.list[widget.index]['tel1']);
    _tel2Controller = TextEditingController(text: widget.list[widget.index]['tel2']);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Update Profile',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('登録情報編集'),
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[
              Container(
                height: 50,
                child: new TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: '名前',
                  ),
                ),
              ),

              Container(
                height: 50,
                child: new TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'email',
                    hintText: 'メールアドレス',
                  ),
                ),
              ),
              Container(
                height: 50,
                child: new TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'tel1',
                    hintText: '連絡先①',
                  ),
                ),
              ),  Container(
                height: 50,
                child: new TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'tel2',
                    hintText: '連絡先②',
                  ),
                ),
              ),
              Padding(padding:  EdgeInsets.only(top: 44.0),),

              Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    void updateData() async {
                      int userId = widget.list[widget.index]['id'] ?? 0;
                      String idValue = userId != null ? userId.toString() : '';
                      if (userId != null) {
                      final data = {
                        'id': userId.toString(),
                        'name': _nameController.text.trim(),
                        'email': _emailController.text.trim(),
                        'tel1': _tel1Controller.text.trim(),
                        'tel2': _tel2Controller.text.trim(),
                      };
                        final Map<String, String> requestData = data.map((key, value) => MapEntry(key, value.toString()));

                        final result = await API().putRequest(
                          route: '/update_user_fl/$userId', data: requestData,
                        );

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Dashboard(title: 'Dashboard'),
                          ),
                        );
                      } else {
                        return print('Some error has Occurred');
                      }


                    }
                    // 呼び出し元のコード内でupdateData()を呼び出す
                    updateData();
                  },
              style: ElevatedButton.styleFrom(primary: Colors.blue),
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                ),
               ),
              )




            ],
          ),
        ),
      ),
    );
  }



  void _showDialog(){
    showDialog(
        context:context ,
        builder:(BuildContext context){
          return AlertDialog(
            title: new Text('Failed'),
            content:  new Text('Check your email or password'),
            actions: <Widget>[
              ElevatedButton(

                child: new Text(
                  'Close',
                ),

                onPressed: (){
                  Navigator.of(context).pop();
                },

              ),
            ],
          );
        }
    );
  }



}














