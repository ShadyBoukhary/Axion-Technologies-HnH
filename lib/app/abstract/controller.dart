import 'package:flutter/material.dart';

abstract class Controller with WidgetsBindingObserver {
  BuildContext context; // needed for navigation
  Function refresh; // callback function for refreshing the UI
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

  /// Dismisses the loading dialog. The parent `View` of this [Controller] should have its body wrapped
  /// in the ModelHUD and is listening to the [Controller]'s [isLoading]. Otherwise, this method will
  /// have no impact.
  void dismissLoading() {
    assert(refresh != null, 'Please set the Controller refresh function inside the View');
    refresh(() => isLoading = false);
  }

  /// Sets the loading to true. The `View` body should be wrapped in a loader.
  /// Call on initial page load. For example, if a loader is needed as soon as you open a page.
  /// Only works when called inside the [Controller] constructor.
  void startLoading() {
    isLoading = true;
  }

  /// Sets the loading to true. The `View` body should be wrapped in a loader.
  /// Call when a loader is needed after an event (e.g. a button press).
  /// Does not work if called inside the [Controller] constructor.
  void resumeLoading() {
    assert(refresh != null, 'Please set the Controller refresh function inside the View');
    refresh(() => isLoading = true);
  }

  void refreshUI() {
    assert(refresh != null, 'Please set the Controller refresh function inside the View');
    refresh((){});
  }

  void initListeners();
  void onInActive() {}
  void onPaused() {}
  void onResumed() {}
  void onSuspending() {}
}
