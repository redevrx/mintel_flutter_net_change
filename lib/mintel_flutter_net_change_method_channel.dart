import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mintel_flutter_net_change_platform_interface.dart';

/// An implementation of [MintelFlutterNetChangePlatform] that uses method channels.
class MethodChannelMintelFlutterNetChange
    extends MintelFlutterNetChangePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final event = const EventChannel('mintel_flutter_net_change');

  @override
  Stream<bool> onConnChange() {
    return event
        .receiveBroadcastStream()
        .map((event) => event as bool? ?? false)
        .distinct();
  }
}
