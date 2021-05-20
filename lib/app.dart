import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'styles.dart';

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  MyApp({Key key, @required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("myBox");
    String username = box.get("username");

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: username == null ? Login() : Home(),
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
      ),
    );
  }
}
