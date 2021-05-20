import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _inputController = new TextEditingController();

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
                    top: 30,
                    bottom: 30,
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
                    bottom: 60,
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
                  autofocus: true,
                  controller: _inputController,
                  decoration: InputDecoration(
                    hintText: "Type GitHub Username",
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 60,
                  ),
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {},
                    splashRadius: 1,
                    icon: Icon(Icons.arrow_right_alt),
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
