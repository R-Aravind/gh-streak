import 'package:flutter/material.dart';
import 'streak.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GH <Streak>"),
      ),
      body: Container(
        child: Streak(),
      ),
    );
  }
}
