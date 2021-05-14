import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        accentColor: accentColor,
        primaryColor: purple,
        canvasColor: accentColor,
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(headline6: AppBarTextStyle),
        ),
        textTheme: TextTheme(
          headline6: TitleTextStyle,
          bodyText2: BodyTextStyle,
        ),
      ),
    );
  }
}
