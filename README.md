# Mintel Flutter Net Change

A Flutter plugin for detecting internet connectivity changes across Android and iOS using Kotlin Multiplatform (KMP).

This plugin exposes a simple cross-platform API to observe network connection changes using Kotlin `Flow` under the hood — giving you real-time updates about internet availability in a reactive way.

---

## 🛠 Features

- ✅ Realtime internet connection monitoring
- ✅ Shared logic built using Kotlin Multiplatform (KMP)
- ✅ Android: Uses `ConnectivityManager` and `Flow<Boolean>`
- ✅ iOS: Uses `NWPathMonitor` and `Flow<Boolean>`
- ✅ Clean Dart API: `observe()` and `isConnected()`
- ✅ No third-party dependencies in Dart

---

## 📦 Installation

Add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  mintel_flutter_net_change:0.0.5
```

```shell
flutter pub get
```

## Permission
- Android
```manifest
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.INTERNET"/>
```

- iOS
```xml
<key>NSLocalNetworkUsageDescription</key>
<string>This app uses local network information to determine internet connection status.</string>
```

## gradle Config
```kotlin
///setting.gradle root level
pluginManagement {
    ....
    repositories {
        mavenLocal()
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

///build.gradle room level
allprojects {
    repositories {
        mavenLocal()
        google()
        mavenCentral()
    }
}
```

## Android MinSdk Support
```kotlin
 minSdkVersion 24  // flutter.minSdkVersion
```


## Architecture Overview
```dart
Flutter (Dart)
↓
Kotlin Multiplatform Shared Library
├── Android: ConnectivityManager
└── iOS: NWPathMonitor
↓
Shared Kotlin Logic (Flow<Boolean>)
```

## Example
```dart
class NetChangeExampleApp extends StatelessWidget {
  const NetChangeExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network Change Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NetStatusScreen(),
    );
  }
}

class NetStatusScreen extends StatefulWidget {
  const NetStatusScreen({super.key});

  @override
  State<NetStatusScreen> createState() => _NetStatusScreenState();
}

class _NetStatusScreenState extends State<NetStatusScreen> {
  final _plugin = NetworkMonitor.instance;
  late final StreamSubscription<bool> _subscription;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _startSubscription();
  }

  void _startSubscription() {
    _subscription = _plugin.onConnectionChange().listen((connected) {
      setState(() {
        _isConnected = connected;
      });
    });
  }
  
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Change Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isConnected ? Icons.wifi : Icons.wifi_off,
              size: 80,
              color: _isConnected ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              _isConnected ? 'You are ONLINE' : 'You are OFFLINE',
              style: TextStyle(
                fontSize: 24,
                color: _isConnected ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
