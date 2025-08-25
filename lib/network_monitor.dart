import 'dart:io';
import 'dart:async';
import 'dart:math';

import 'mintel_flutter_net_change_platform_interface.dart';

class NetworkMonitor {
  NetworkMonitor._internal();

  static final _instance = NetworkMonitor._internal();

  static NetworkMonitor get instance => _instance;

  final platform = MintelFlutterNetChangePlatform.instance;

  final _hosts = <String>[];
  final _defaultHost = <String>[
    "https://clients3.google.com/generate_204",
    "https://www.google.com",
    "https://httpbin.org/status/200",
  ];

  List<String> get _mHosts => _hosts.isEmpty ? _defaultHost : _hosts;

  void setHost(List<String> hosts) {
    _hosts.clear();
    _hosts.addAll(hosts);
  }

  void addHost(String host) {
    if (!_hosts.contains(host)) {
      _hosts.add(host);
    }
  }

  void clearHosts() {
    _hosts.clear();
  }

  Stream<bool> onConnectionChange() => platform.onConnChange();

  Future<bool> get hasInternet async {
    final shuffledHosts = [..._mHosts];
    shuffledHosts.shuffle(Random());

    for (final host in shuffledHosts) {
      HttpClient? client;
      try {
        client = HttpClient();
        client.connectionTimeout = Duration(seconds: 10);
        client.idleTimeout = Duration(seconds: 5);

        final request = await client.headUrl(Uri.parse(host));
        request.headers.set('User-Agent', 'NetworkMonitor/1.0');
        request.headers.set('Cache-Control', 'no-cache');

        final response = await request.close();

        if (response.statusCode >= 200 && response.statusCode < 300) {
          return true;
        }
      } catch (e) {
        continue;
      } finally {
        client?.close(force: true);
      }
    }

    return false;
  }

  Future<bool> get hasInternetFast async {
    final socketHosts = [
      {'host': '8.8.8.8', 'port': 53}, // Google DNS
      {'host': '1.1.1.1', 'port': 53}, // Cloudflare DNS
      {'host': '208.67.222.222', 'port': 53}, // OpenDNS
      {'host': '8.8.4.4', 'port': 53}, // Google Secondary DNS
    ];

    socketHosts.shuffle(Random());

    for (final hostInfo in socketHosts) {
      Socket? socket;
      try {
        socket = await Socket.connect(
          hostInfo['host'] as String,
          hostInfo['port'] as int,
          timeout: Duration(seconds: 3),
        );

        return true;
      } catch (e) {
        continue;
      } finally {
        socket?.destroy();
      }
    }

    return false;
  }

  Future<bool> get isConnected async {
    try {
      if (await hasInternetFast) {
        return true;
      }
      return await hasInternet;
    } catch (e) {
      return false;
    }
  }

  @Deprecated('Use hasInternet instead')
  Future<bool> get isHasInternet => hasInternet;
}
