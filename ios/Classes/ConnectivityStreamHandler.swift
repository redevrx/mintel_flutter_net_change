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
    private var  onConnected: FlowX<KotlinBoolean>?
    
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        observer = ConnectivityObserver()
        
        self.onConnected = observer?.onConnected
        
        self.onConnected?.subscribe { it in
            if let connected = it as? KotlinBoolean {
                DispatchQueue.main.async {
                    self.eventSink?(connected.boolValue)
                }
            }else {
                DispatchQueue.main.async {
                    self.eventSink?(false)
                }
            }
        } onCompletion: { err in
            self.eventSink?(false)
        }


//        observer?.internetChange { [weak self] connected in
//            DispatchQueue.main.async {
//                self?.eventSink?(connected.boolValue)
//            }
//        }
    
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        onConnected?.cancel()
        observer?.stop()
        observer = nil
        eventSink = nil
        return nil
    }
}
