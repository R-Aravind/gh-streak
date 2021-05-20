import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv.load(fileName: ".env");
  await initHiveForFlutter();
  var box = await Hive.openBox("myBox");

  final HttpLink httpLink = HttpLink(
    DotEnv.env["API_URL"],
  );
  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer ${DotEnv.env["AUTH_TOKEN"]}',
  );
  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(MyApp(client: client));
}
