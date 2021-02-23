import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Internet connectivity'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;

    final message = hasInternet
        ? 'You have again ${result.toString()}'
        : 'You have no internet';
    final color = hasInternet ? Colors.green : Colors.red;

    showBottomSnackBar(context, message, color);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
//        child: ElevatedButton(
//          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(12)),
//          child: Text('Check Connection', style: TextStyle(fontSize: 20)),
//          onPressed: () async {
//            final result = await Connectivity().checkConnectivity();
//            showConnectivitySnackBar(result);
//          },
//        ),
          ),
    );
  }

  showBottomSnackBar(BuildContext context, String message, Color color) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
