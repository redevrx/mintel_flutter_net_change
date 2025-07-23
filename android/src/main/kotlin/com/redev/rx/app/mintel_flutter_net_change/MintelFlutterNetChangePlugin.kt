package com.redev.rx.app.mintel_flutter_net_change

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel

/** MintelFlutterNetChangePlugin */
class MintelFlutterNetChangePlugin: FlutterPlugin {
  private lateinit var eventChannel: EventChannel
  private lateinit var handle: StreamEventHandle

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger,"mintel_flutter_net_change")
    handle = StreamEventHandle(flutterPluginBinding.applicationContext)

    eventChannel.setStreamHandler(handle)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    eventChannel.setStreamHandler(null)
    handle.onRelease()
  }
}
