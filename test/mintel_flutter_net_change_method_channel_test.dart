import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mintel_flutter_net_change/mintel_flutter_net_change_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const EventChannel channel = EventChannel('mintel_flutter_net_change');
  final platform = MethodChannelMintelFlutterNetChange();

  test('onConnChange emits events from mock stream handler', () async {
    final emitted = <bool>[];

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockStreamHandler(channel, _MockStreamHandler());

    final sub = platform.onConnChange().listen(emitted.add);
    await Future.delayed(const Duration(milliseconds: 100));
    await sub.cancel();

    expect(emitted, [true, false, true]);
  });
}

class _MockStreamHandler extends MockStreamHandler {
  @override
  Future<void> onListen(
    Object? arguments,
    MockStreamHandlerEventSink events,
  ) async {
    events.success(true);
    events.success(false);
    events.success(true);
    events.endOfStream();
  }

  @override
  Future<void> onCancel(Object? arguments) async {}
}
