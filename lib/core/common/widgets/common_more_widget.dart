import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';

// ── Menu entry models ─────────────────────────────────────────────────────────

abstract class AppMenuEntry {
  const AppMenuEntry();
}

/// Non-selectable section header label.
class AppMenuHeaderEntry extends AppMenuEntry {
  final String label;

  const AppMenuHeaderEntry(this.label);
}

/// Visual divider between menu sections.
class AppMenuDividerEntry extends AppMenuEntry {
  const AppMenuDividerEntry();
}

/// Selectable item row with icon, title, and optional subtitle.
class AppMenuItemEntry extends AppMenuEntry {
  final IconData icon;
  final String title;
  final String? subtitle;

  const AppMenuItemEntry({required this.icon, required this.title, this.subtitle});
}

// ── Widget ────────────────────────────────────────────────────────────────────

/// A reusable popup-menu trigger widget.
///
/// Usage:
/// ```dart
/// CommonMoreWidget(
///   triggerIcon: Icons.home_work_rounded,
///   items: [
///     const AppMenuHeaderEntry('SWITCH PROJECT'),
///     AppMenuItemEntry(icon: Icons.apartment_rounded, title: 'The Emerald Pavilion', subtitle: 'UNIT 402'),
///     const AppMenuDividerEntry(),
///     AppMenuItemEntry(icon: Icons.add_circle_outline_rounded, title: 'Add New Property'),
///   ],
///   onSelected: (item) => print(item.title),
/// )
/// ```
class CommonMoreWidget extends StatelessWidget {
  /// Items to render in the popup menu.
  final List<AppMenuEntry> items;

  /// Called when a selectable [AppMenuItemEntry] is tapped.
  final void Function(AppMenuItemEntry item)? onSelected;

  /// Icon for the default trigger button. Ignored if [triggerWidget] is set.
  final IconData triggerIcon;

  /// Fully custom trigger widget. Replaces the default icon button.
  final Widget? triggerWidget;

  const CommonMoreWidget({super.key, required this.items, this.onSelected, this.triggerIcon = Icons.more_vert, this.triggerWidget});

  Future<void> _show(BuildContext context, Offset tapPosition) async {
    final colors = context.colors;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject()! as RenderBox;

    final selected = await showMenu<AppMenuItemEntry>(
      context: context,
      color: colors.surfaceContainer,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      position: RelativeRect.fromRect(Rect.fromPoints(tapPosition, tapPosition), Offset.zero & overlay.size),
      items: _buildItems(context),
    );

    if (selected != null) onSelected?.call(selected);
  }

  List<PopupMenuEntry<AppMenuItemEntry>> _buildItems(BuildContext context) {
    final colors = context.colors;
    final entries = <PopupMenuEntry<AppMenuItemEntry>>[];

    for (final entry in items) {
      switch (entry) {
        case AppMenuHeaderEntry(:final label):
          entries.add(
            PopupMenuItem<AppMenuItemEntry>(
              enabled: false,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Text(
                label.toUpperCase(),
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: colors.onSurfaceDim, letterSpacing: 1.2),
              ),
            ),
          );

        case AppMenuDividerEntry():
          entries.add(const PopupMenuDivider());

        case AppMenuItemEntry():
          final item = entry;
          entries.add(
            PopupMenuItem<AppMenuItemEntry>(
              value: item,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: _ItemRow(item: item),
            ),
          );
      }
    }

    return entries;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final trigger =
        triggerWidget ??
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: colors.primaryTealFixed,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: colors.onPrimaryTeal.withValues(alpha: 0.25), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Icon(triggerIcon, size: 18, color: colors.white),
        );

    return GestureDetector(onTapDown: (d) => _show(context, d.globalPosition), child: trigger);
  }
}

// ── Private item row ──────────────────────────────────────────────────────────

class _ItemRow extends StatelessWidget {
  final AppMenuItemEntry item;

  const _ItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: colors.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(item.icon, size: 16, color: colors.primaryTeal),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.title, style: AppTextStyles.s13Medium.copyWith(color: colors.onSurface)),
            if (item.subtitle != null) ...[
              const SizedBox(height: 1),
              Text(item.subtitle!, style: AppTextStyles.s10Regular.copyWith(color: colors.onSurfaceDim, letterSpacing: 0.5)),
            ],
          ],
        ),
      ],
    );
  }
}
