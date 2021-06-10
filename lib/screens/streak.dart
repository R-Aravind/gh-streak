import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hive/hive.dart';
import '../providers/user_query.dart';
import '../helpers/calc_streak.dart';

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

        final streakData = calcStreak(weeks);

        return Container(
          margin: EdgeInsets.only(
            top: 50,
            left: 35,
            right: 30,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          result.data["user"]["avatarUrl"],
                          height: 150,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              "${result.data["user"]["name"]}",
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 22,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              "[${result.data["user"]["name"]}]",
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(3),
                child: Text(
                  "${result.data["user"]["bio"]}",
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MaterialCommunityIcons.fire,
                              color: Colors.red,
                            ),
                            Text("${streakData['streak']}"),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text("Current Streak"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(MaterialCommunityIcons.fire),
                            Text("${streakData['longestStreak']}"),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text("Longest Streak"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(MaterialCommunityIcons.emoticon_happy),
                            Text(" ${streakData['contribToday']}"),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text("Contributions Today"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Built with  ",
                      ),
                      WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            FontAwesome.heart,
                            size: 16,
                          )),
                    ],
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
