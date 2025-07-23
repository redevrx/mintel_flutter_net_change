import 'package:flutter/material.dart';
import 'package:mintel_flutter_net_change/mintel_flutter_net_change.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _plugin = NetworkMonitor.instance;

  @override
  void initState() {
    super.initState();
    subscriptionNetChange();
  }

  bool isConnected = false;
  void subscriptionNetChange() {
    _plugin.onConnectionChange().listen((isConnected) {
      print("isConnected change: $isConnected");
      setState(() {
        this.isConnected = isConnected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(child: Text('Running on: $isConnected\n')),
      ),
    );
  }
}
