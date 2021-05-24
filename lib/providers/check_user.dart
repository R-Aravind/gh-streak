import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:hive/hive.dart';

Future checkUser(String username) async {
  var box = Hive.box("mainBox");
  http.Response response = await http.get(
    Uri.parse("https://api.github.com/users/" + username),
    headers: {"Authorisation": "Bearer ${DotEnv.env["AUTH_TOKEN"]}"},
  );

  if (response.statusCode == 200) {
    box.put("username", username);
    return true;
  } else {
    return false;
  }
}
