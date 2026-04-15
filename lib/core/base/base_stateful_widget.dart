import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/router/route_observer.dart';

/// Base class for all stateful pages.
/// Pair with [BaseState]. Override [buildContent] instead of [build].
abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({super.key});
}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T> with WidgetsBindingObserver, RouteAware {
  // ---------------------------------------------------------------------------
  // Private connectivity state
  // ---------------------------------------------------------------------------

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _wasConnected = true;
  bool _isFirstLoad = true;

  // ---------------------------------------------------------------------------
  // Lifecycle hooks — override as needed
  // ---------------------------------------------------------------------------

  /// Synchronous setup. Called in [initState].
  @protected
  void onInit() {}

  /// Async setup. Called after the first frame (post-frame callback).
  @protected
  Future<void> onInitAsync() async {}

  /// Page is now visible (pushed or returned to).
  @protected
  void onVisible() {}

  /// Page is now hidden (covered by another page or paused).
  @protected
  void onInvisible() {}

  /// Called in [dispose] before super.
  @protected
  void onDispose() {}

  /// Network status changed. [isConnected] reflects the new state.
  @protected
  void onConnectivityChanged(bool isConnected) {}

  // ---------------------------------------------------------------------------
  // Utilities
  // ---------------------------------------------------------------------------

  @protected
  void logError(Object error, [StackTrace? stackTrace]) {
    debugPrint('[ERROR] $error');
    if (stackTrace != null) debugPrint('[STACK] $stackTrace');
  }

  /// Returns [light] or [dark] value based on the current theme brightness.
  @protected
  V getThemeValue<V>({required V light, required V dark}) => Theme.of(context).brightness == Brightness.light ? light : dark;

  // ---------------------------------------------------------------------------
  // Flutter lifecycle
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkConnectivity();
      _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_handleConnectivityChange);
      await onInitAsync();
      _isFirstLoad = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) routeObserver.subscribe(this, route);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _connectivitySubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    onDispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // App lifecycle (via WidgetsBindingObserver)
  // ---------------------------------------------------------------------------

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _checkConnectivity();
      case AppLifecycleState.paused:
        onInvisible();
      default:
        break;
    }
  }

  // ---------------------------------------------------------------------------
  // Route awareness (via RouteAware)
  // ---------------------------------------------------------------------------

  @override
  void didPush() {
    if (!_isFirstLoad) onVisible();
  }

  @override
  void didPopNext() => onVisible();

  @override
  void didPushNext() => onInvisible();

  @override
  void didPop() => onInvisible();

  // ---------------------------------------------------------------------------
  // Connectivity
  // ---------------------------------------------------------------------------

  Future<void> _checkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _handleConnectivityChange(result);
    } catch (e, s) {
      logError(e, s);
    }
  }

  void _handleConnectivityChange(List<ConnectivityResult> result) {
    final isConnected = !result.contains(ConnectivityResult.none);
    if (isConnected == _wasConnected) return;
    _wasConnected = isConnected;
    onConnectivityChanged(isConnected);
    _showConnectivitySnackBar(isConnected);
  }

  void _showConnectivitySnackBar(bool isConnected) {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;
    final backgroundColor = isConnected ? ColorPalette.primaryGreen : ColorPalette.red600;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(isConnected ? 'Back online' : 'No internet connection'),
          backgroundColor: backgroundColor,
          duration: isConnected ? const Duration(seconds: 2) : const Duration(days: 1),
        ),
      );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) => buildContent(context);

  @protected
  Widget buildContent(BuildContext context);
}
