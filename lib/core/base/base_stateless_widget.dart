import 'package:flutter/material.dart';

/// Base class for all stateless pages.
/// Override [buildContent] instead of [build].
abstract class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({super.key});

  // ─── Utilities ─────────────────────────────────────────────────────────────

  @protected
  void logError(Object error, [StackTrace? stackTrace]) {
    debugPrint('[ERROR] $error');
    if (stackTrace != null) debugPrint('[STACK] $stackTrace');
  }

  @protected
  V getThemeValue<V>(BuildContext context, {required V light, required V dark}) => Theme.of(context).brightness == Brightness.light ? light : dark;

  // ─── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) => buildContent(context);

  @protected
  Widget buildContent(BuildContext context);
}
