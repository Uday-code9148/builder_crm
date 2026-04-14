import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateless_widget.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';

class MoreMenuWidget extends BaseStatelessWidget {
  const MoreMenuWidget({super.key});

  void _showMenu(BuildContext context, Offset position) async {
    final colors = context.colors;
    await showMenu(
      context: context,
      color: colors.surfaceContainer,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + 8,
        position.dx + 240,
        position.dy,
      ),
      items: <PopupMenuEntry<Object>>[
        PopupMenuItem<Object>(
          enabled: false,
          child: Text(
            'SWITCH PROJECT',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: colors.onSurfaceDim,
              letterSpacing: 1.2,
            ),
          ),
        ),
        PopupMenuItem<Object>(
          child: _menuItem(context, Icons.apartment_rounded, 'The Emerald Pavilion', 'UNIT 402 · Active'),
        ),
        PopupMenuItem<Object>(
          child: _menuItem(context, Icons.domain_rounded, 'Skyline Residencies', 'UNIT 201 · Upcoming'),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<Object>(
          child: _menuItem(context, Icons.add_circle_outline_rounded, 'Add New Property', null),
        ),
      ],
    );
  }

  Widget _menuItem(BuildContext context, IconData icon, String title, String? subtitle) {
    final colors = context.colors;
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: colors.primaryTeal.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: colors.primaryTeal),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: AppTextStyles.s13Medium.copyWith(color: colors.onSurface)),
            if (subtitle != null) ...[
              const SizedBox(height: 1),
              Text(subtitle,
                  style: AppTextStyles.s10Regular.copyWith(
                    color: colors.onSurfaceDim,
                    letterSpacing: 0.5,
                  )),
            ],
          ],
        ),
      ],
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTapDown: (details) => _showMenu(context, details.globalPosition),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: colors.primaryTealFixed,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: colors.onPrimaryTeal.withValues(alpha: 0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(Icons.home_work_rounded, size: 18, color: colors.white),
      ),
    );
  }
}
