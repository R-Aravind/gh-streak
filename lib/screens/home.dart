import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GH <Streak>"),
      ),
      body: Container(
        child: Center(
          child: Text("GH Streak"),
        ),
      ),
    );
  }
}
