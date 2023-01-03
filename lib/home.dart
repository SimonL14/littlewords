import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainpage.dart';

class home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFF5CB2E8)),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool newuser = (prefs.getBool('login') ?? true);

    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MyDashboard()));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              alignment: Alignment.topCenter,
              child: Image.asset('Assets/Logo.png', height: 300,
                width: 400,)),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 80,
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0),
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),

              child: TextField(
                controller: username_controller,
                decoration: InputDecoration(

                  filled: true, //<-- SEE HERE
                  fillColor: Color(0xFF5CB2E8),
                  labelText: 'username',
                ),
              ),
            ),
          ),
          GestureDetector(child: Image.asset("Assets/jouer.png", height: 150,
            width: 300,), onTap: () async {
            String username = username_controller.text;


            if (username != '') {
              print('Successfull');
              var prefs = await SharedPreferences.getInstance();
              prefs.setBool('login', false);

              prefs.setString('username', username);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyDashboard()));
            }
          }),
        ],
      ),
    );
  }
}