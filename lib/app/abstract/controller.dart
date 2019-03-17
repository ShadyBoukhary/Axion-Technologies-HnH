import 'package:flutter/material.dart';

abstract class Controller with WidgetsBindingObserver {
  
  BuildContext context; // needed for navigation
  Function refresh;  // callback function for refreshing the UI
  bool isLoading; // indicates whether a loading dialog is present

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

  void dismissLoading() {
    assert(refresh != null);
    refresh(() => isLoading = false);
  }

  void initListeners();
  void onInActive() {}
  void onPaused() {}
  void onResumed() {}
  void onSuspending() {}
}
