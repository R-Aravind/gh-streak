import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'screens/home.dart';
import 'styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv.load(fileName: ".env");
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    DotEnv.env["API_URL"],
  );
  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer ${DotEnv.env["AUTH_TOKEN"]}',
  );
  // final Link link = authLink.concat(httpLink);
  final Link link = httpLink;

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  MyApp({Key key, @required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
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
      ),
    );
  }
}
