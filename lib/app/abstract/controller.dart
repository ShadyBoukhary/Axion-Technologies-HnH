import 'package:flutter/material.dart';

abstract class Controller with WidgetsBindingObserver {
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        onInActive();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.suspending:
        onSuspending();
        break;
    }
  }
  void initListeners();
  void onInActive() {}
  void onPaused() {}
  void onResumed() {}
  void onSuspending() {}
}
