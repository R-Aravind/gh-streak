import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../providers/check_user.dart';
import 'loading.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _inputController = new TextEditingController();

  void _handleLogin() async {
    if (_inputController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Loading(
            username: _inputController.text,
          ),
        ),
      );
      bool loginSuccess = await checkUser(_inputController.text);
      Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
      if (loginSuccess) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "User "),
                  TextSpan(
                    text: "${_inputController.text}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " doesn't exist"),
                ],
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            action: SnackBarAction(label: "OK", onPressed: () {}),
            duration: Duration(milliseconds: 1500),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            padding: EdgeInsets.only(
              top: 10,
              left: 40,
              right: 20,
              bottom: 10,
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.only(
            left: 40,
            right: 40,
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 70,
                    bottom: 20,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "GH <Streak>",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 100,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Login with your GitHub username to keep track of your contribution stats.",
                    style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                TextField(
                  autocorrect: false,
                  autofocus: false,
                  controller: _inputController,
                  decoration: InputDecoration(
                    hintText: "Type GitHub Username",
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                  onEditingComplete: _handleLogin,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 60,
                  ),
                  alignment: Alignment.center,
                  child: IconButton(
                    splashRadius: 1,
                    color: Theme.of(context).primaryColor,
                    iconSize: 60,
                    icon: Icon(MaterialCommunityIcons.chevron_right),
                    onPressed: _handleLogin,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
