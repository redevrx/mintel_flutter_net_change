import 'package:flutter_test/flutter_test.dart';
import 'package:mintel_flutter_net_change/mintel_flutter_net_change_platform_interface.dart';
import 'package:mintel_flutter_net_change/mintel_flutter_net_change_method_channel.dart';
import 'package:mintel_flutter_net_change/network_monitor.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMintelFlutterNetChangePlatform
    with MockPlatformInterfaceMixin
    implements MintelFlutterNetChangePlatform {
  @override
  Stream<bool> onConnChange() {
    return Stream.value(true);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MintelFlutterNetChangePlatform initialPlatform =
      MintelFlutterNetChangePlatform.instance;

  tearDown(() {
    MintelFlutterNetChangePlatform.instance = initialPlatform;
  });

  test('$MethodChannelMintelFlutterNetChange is the default instance', () {
    expect(
      initialPlatform,
      isInstanceOf<MethodChannelMintelFlutterNetChange>(),
    );
  });

  test('NetworkMonitor.onConnectionChange returns stream from mock', () async {
    final monitor = NetworkMonitor.instance;
    MintelFlutterNetChangePlatform.instance =
        MockMintelFlutterNetChangePlatform();

    monitor.onConnectionChange().listen((event) {
      expect(event, true);
    });
  });
}
