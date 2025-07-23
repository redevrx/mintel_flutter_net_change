package com.redev.rx.app.mintel_flutter_net_change

import android.content.Context
import com.redev.rx.rx_connection_change.ConnectivityObserver
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.cancelChildren
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.onEach

class StreamEventHandle(context: Context): EventChannel.StreamHandler {
    private val connectivity = ConnectivityObserver(context)
    private val scope = CoroutineScope(SupervisorJob()+ Dispatchers.Main.immediate)
    private var sink: EventChannel.EventSink? = null

    override fun onListen(
        arguments: Any?,
        events: EventChannel.EventSink?
    ) {
        sink = events

        connectivity.isConnected.onEach(::onTrySend).launchIn(scope)
    }

    override fun onCancel(arguments: Any?) {
        sink = null
        scope.coroutineContext.cancelChildren()
    }

    private fun onTrySend(value: Boolean){
        sink?.success(value)
    }

    fun onRelease(){
        scope.cancel()
    }
}