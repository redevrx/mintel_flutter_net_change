import Flutter
import UIKit

public class MintelFlutterNetChangePlugin: NSObject, FlutterPlugin {
    private var eventChannel:FlutterEventChannel? = nil
    private var streamHandler: ConnectivityStreamHandler?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = MintelFlutterNetChangePlugin()
        instance.setupChannel(registrar: registrar)
    }
    
    private func setupChannel(registrar: FlutterPluginRegistrar) {
        eventChannel = FlutterEventChannel(name: "mintel_flutter_net_change", binaryMessenger: registrar.messenger())
        streamHandler = ConnectivityStreamHandler()
        eventChannel?.setStreamHandler(streamHandler)
    }
}
