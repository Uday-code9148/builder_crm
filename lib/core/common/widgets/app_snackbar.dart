import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';

enum SnackbarType { success, warning, error }

class AppSnackbar {
  static final List<OverlayEntry> _active = [];

  static void show({BuildContext? context, GlobalKey<NavigatorState>? navigatorKey, required String message, SnackbarType type = SnackbarType.success, Duration duration = const Duration(seconds: 2), String? actionLabel, VoidCallback? onAction, bool persistent = false}) {
    assert(context != null || navigatorKey != null, 'Provide either context or navigatorKey.');

    final overlay = context != null ? Overlay.of(context) : navigatorKey!.currentState!.overlay!;

    _dismissAll();

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (ctx) => Positioned(
        top: MediaQuery.of(ctx).viewInsets.top + 50,
        left: 16,
        right: 16,
        child: _SnackbarWidget(type: type, message: message, actionLabel: actionLabel, onAction: onAction, onDismissed: () => _dismiss(entry)),
      ),
    );

    _active.add(entry);
    overlay.insert(entry);

    if (!persistent) {
      Future.delayed(duration, () {
        if (_active.contains(entry)) _dismiss(entry);
      });
    }
  }

  static void showSuccess({BuildContext? context, GlobalKey<NavigatorState>? navigatorKey, required String message}) => show(context: context, navigatorKey: navigatorKey, message: message, type: SnackbarType.success);

  static void showError({BuildContext? context, GlobalKey<NavigatorState>? navigatorKey, required String message}) => show(context: context, navigatorKey: navigatorKey, message: message, type: SnackbarType.error);

  static void showWarning({BuildContext? context, GlobalKey<NavigatorState>? navigatorKey, required String message}) => show(context: context, navigatorKey: navigatorKey, message: message, type: SnackbarType.warning);

  static void _dismissAll() {
    for (final e in _active) {
      e.remove();
    }
    _active.clear();
  }

  static void _dismiss(OverlayEntry entry) {
    if (_active.contains(entry)) {
      entry.remove();
      _active.remove(entry);
    }
  }
}

// ─── Internal widget ──────────────────────────────────────────────────────────

class _SnackbarWidget extends StatefulWidget {
  final SnackbarType type;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback onDismissed;

  const _SnackbarWidget({required this.type, required this.message, required this.onDismissed, this.actionLabel, this.onAction});

  @override
  State<_SnackbarWidget> createState() => _SnackbarWidgetState();
}

class _SnackbarWidgetState extends State<_SnackbarWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _slide = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slide,
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.horizontal,
        onDismissed: (_) => widget.onDismissed(),
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: _backgroundColor, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Icon(_icon, color: ColorPalette.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(widget.message, style: AppTextStyles.s12Regular.copyWith(color: ColorPalette.white)),
                ),
                if (widget.actionLabel != null && widget.onAction != null)
                  TextButton(
                    onPressed: widget.onAction,
                    child: Text(widget.actionLabel!, style: AppTextStyles.s12Bold.copyWith(color: ColorPalette.white)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData get _icon => switch (widget.type) {
    SnackbarType.success => Icons.check_circle_outline,
    SnackbarType.warning => Icons.warning_amber_outlined,
    SnackbarType.error => Icons.error_outline,
  };

  Color get _backgroundColor => switch (widget.type) {
    SnackbarType.success => ColorPalette.primaryGreen,
    SnackbarType.warning => ColorPalette.yellow100Accent,
    SnackbarType.error => ColorPalette.fadedRed,
  };
}
