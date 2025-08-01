import 'dart:io';

import 'mintel_flutter_net_change_platform_interface.dart';

class NetworkMonitor {
  NetworkMonitor._internal();

  static final _instance = NetworkMonitor._internal();

  static NetworkMonitor get instance => _instance;

  final platform = MintelFlutterNetChangePlatform.instance;

  Stream<bool> onConnectionChange() => platform.onConnChange();

  Future<bool> get isHasInternet async {
    final result = await InternetAddress.lookup("google.com");
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  }
}
