import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

class NetworkAware extends StatefulWidget {
  final Widget child;
  final bool showScaffold;

  NetworkAware({@required this.child, this.showScaffold = true});

  @override
  _NetworkAwareState createState() => _NetworkAwareState();
}

class _NetworkAwareState extends State<NetworkAware> {
  var listener;
  bool _isConnected = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          setState(() {
            _loading = false;
            _isConnected = true;
          });
          break;
        case DataConnectionStatus.disconnected:
          setState(() {
            _loading = false;
            _isConnected = false;
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnected) {
      return widget.child;
    } else if (!widget.showScaffold) {
      return Container(
        child: Center(
          child: _loading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "Please check your Internet Connection",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(" "),
          elevation: 0,
          bottom: PreferredSize(
            child: Container(
              color: Colors.grey.withOpacity(0.2),
              height: 1,
            ),
            preferredSize: Size.fromHeight(1),
          ),
        ),
        body: Container(
          child: Center(
            child: _loading
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          "Please check your Internet Connection",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }
}
