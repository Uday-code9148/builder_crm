import 'dart:async';
import 'dart:ui';

/// Delays execution of [action] until [milliseconds] have passed since the
/// last [run] call. Useful for search fields and live-filter inputs.
///
/// ```dart
/// final _debouncer = Debouncer(milliseconds: 400);
///
/// onChanged: (text) => _debouncer.run(() => _search(text)),
/// ```
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void cancel() => _timer?.cancel();

  bool get isRunning => _timer?.isActive ?? false;
}
