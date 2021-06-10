import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'streak.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("mainBox");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey.withOpacity(0.4),
            height: 1,
          ),
          preferredSize: Size.fromHeight(1),
        ),
        title: Text(
          "GH <Streak>",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Theme.of(context).primaryColor),
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
