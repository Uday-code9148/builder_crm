import 'package:flutter/widgets.dart';

/// A lightweight [WidgetsBindingObserver] that delegates lifecycle changes
/// to a single callback. Register in [main] or any long-lived widget.
///
/// ```dart
/// final _observer = AppLifecycleObserver(onStateChange: (state) {
///   if (state == AppLifecycleState.resumed) { ... }
/// });
///
/// WidgetsBinding.instance.addObserver(_observer);
/// ```
class AppLifecycleObserver with WidgetsBindingObserver {
  final void Function(AppLifecycleState state) onStateChange;

  AppLifecycleObserver({required this.onStateChange});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    onStateChange(state);
  }
}
