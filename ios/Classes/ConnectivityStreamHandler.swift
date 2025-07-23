//
//  ConnectivityStreamHandler.swift
//  Pods
//
//  Created by Kasem Saikhuedong on 22/7/2568 BE.
//

import Flutter
import Shared

class ConnectivityStreamHandler: NSObject , FlutterStreamHandler {
    private var observer: ConnectivityObserver?
    private var eventSink: FlutterEventSink?
    
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        observer = ConnectivityObserver()
        
        observer?.internetChange { [weak self] connected in
            DispatchQueue.main.async {
                self?.eventSink?(connected.boolValue)
            }
        }
    
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        observer?.stop()
        observer = nil
        eventSink = nil
        return nil
    }
}
