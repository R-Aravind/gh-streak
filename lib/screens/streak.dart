import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../providers/user_query.dart';

class Streak extends StatefulWidget {
  @override
  _StreakState createState() => _StreakState();
}

class _StreakState extends State<Streak> {
  final String _query = dataQuery;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(_query), variables: {
        'Username': "lemokami",
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

        print(result.data["user"]);
        return Container(
          child: Text(result.data["user"]["name"]),
        );
      },
    );
  }
}
