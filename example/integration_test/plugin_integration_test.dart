// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:mintel_flutter_net_change/mintel_flutter_net_change.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('NetworkMonitor emits connection change events', (
    WidgetTester tester,
  ) async {
    final plugin = NetworkMonitor.instance;
    final events = <bool>[];

    final subscription = plugin.onConnectionChange().listen(events.add);

    await Future.delayed(const Duration(seconds: 5));
    await subscription.cancel();

    expect(
      events.isNotEmpty,
      true,
      reason: 'Should receive connection change events',
    );
    debugPrint('Received connection events: $events');
  });
}
