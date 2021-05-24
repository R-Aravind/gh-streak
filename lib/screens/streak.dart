import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import '../providers/user_query.dart';

class Streak extends StatefulWidget {
  @override
  _StreakState createState() => _StreakState();
}

class _StreakState extends State<Streak> {
  final String _query = dataQuery;

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("mainBox");
    String username = box.get("username");

    return Query(
      options: QueryOptions(document: gql(_query), variables: {
        'Username': username,
      }),
      builder: (
        QueryResult result, {
        VoidCallback refetch,
        FetchMore fetchMore,
      }) {
        if (result.hasException) {
          return Container(
            child: Center(
              child: Text(result.exception.toString()),
            ),
          );
        }

        if (result.isLoading) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        List weeks = result.data["user"]["contributionsCollection"]
            ["contributionCalendar"]["weeks"];
        return Container(
          child: Text(result.data["user"]["name"]),
        );
      },
    );
  }
}
