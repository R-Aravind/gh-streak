import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'streak.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("mainBox");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GH <Streak>",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Theme.of(context).accentColor),
            onPressed: () {
              box.delete("username");
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Container(
        child: Streak(),
      ),
    );
  }
}
