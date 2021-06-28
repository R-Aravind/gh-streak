import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String username, messageString;

  Loading(
      {this.username = "", this.messageString = "Oops! There is an error."});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: 80,
          right: 80,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              minHeight: 3,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                  children: username != ""
                      ? [
                          TextSpan(text: "Hi "),
                          TextSpan(
                            text: "$username!",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: "\nsearching GitHub for you"),
                        ]
                      : [
                          TextSpan(text: messageString),
                        ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
