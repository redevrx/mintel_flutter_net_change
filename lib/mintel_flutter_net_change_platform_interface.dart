import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mintel_flutter_net_change_method_channel.dart';

abstract class MintelFlutterNetChangePlatform extends PlatformInterface {
  /// Constructs a MintelFlutterNetChangePlatform.
  MintelFlutterNetChangePlatform() : super(token: _token);

  static final Object _token = Object();

  static MintelFlutterNetChangePlatform _instance =
      MethodChannelMintelFlutterNetChange();

  /// The default instance of [MintelFlutterNetChangePlatform] to use.
  ///
  /// Defaults to [MethodChannelMintelFlutterNetChange].
  static MintelFlutterNetChangePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MintelFlutterNetChangePlatform] when
  /// they register themselves.
  static set instance(MintelFlutterNetChangePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<bool> onConnChange();
}
