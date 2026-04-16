import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateless_widget.dart';
import 'package:temp_architecture_app_setup/core/common/constants/app_display_constants.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/curator_glass_app_bar.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';

class ProfilePage extends BaseStatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.surface,
      appBar: buildCuratorGlassAppBar(
        context: context,
        title: 'My Profile',
        projectWidget: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: colors.primaryTealFixed,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: colors.onPrimaryTeal.withValues(alpha: 0.25), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Icon(Icons.person_rounded, size: 18, color: colors.white),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 24),
                _buildAvatarCard(context),
                const SizedBox(height: 20),
                _buildStatsRow(context),
                const SizedBox(height: 28),
                _buildSectionLabel(context, 'Personal Information'),
                const SizedBox(height: 10),
                _buildGroup(context, const [
                  _InfoRow(icon: Icons.person_outline_rounded, label: 'Full Name', value: 'Uday Kumar', editable: true),
                  _InfoRow(icon: Icons.email_outlined, label: 'Email', value: 'udaykumar@leadrat.com', editable: true),
                  _InfoRow(icon: Icons.phone_outlined, label: 'Phone', value: '+91 98765 43210', editable: true),
                  _InfoRow(icon: Icons.cake_outlined, label: 'Date of Birth', value: '15 Aug 1995', editable: true),
                ]),
                const SizedBox(height: 24),
                _buildSectionLabel(context, 'Property Details'),
                const SizedBox(height: 10),
                _buildGroup(context, const [
                  _InfoRow(icon: Icons.apartment_rounded, label: 'Project', value: AppDisplayConstants.projectName),
                  _InfoRow(icon: Icons.home_work_outlined, label: 'Unit', value: 'Unit 402'),
                  _InfoRow(icon: Icons.layers_outlined, label: 'Phase', value: 'Possession Phase'),
                  _InfoRow(icon: Icons.calendar_today_outlined, label: 'Booking Date', value: '12 Mar 2023'),
                ]),
                const SizedBox(height: 24),
                _buildSectionLabel(context, 'Preferences'),
                const SizedBox(height: 10),
                _buildPreferencesCard(context),
                const SizedBox(height: 28),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarCard(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.primaryTeal, colors.primaryTeal.withValues(alpha: 0.6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(color: colors.primaryTeal.withValues(alpha: 0.3), blurRadius: 18, offset: const Offset(0, 6)),
                  ],
                ),
                child: Center(
                  child: Text(
                    'UK',
                    style: AppTextStyles.s18SemiBold.copyWith(color: colors.onPrimaryTeal, letterSpacing: 1.5),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHigh,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.surfaceContainer, width: 2),
                  ),
                  child: Icon(Icons.edit_rounded, size: 11, color: colors.primaryTeal),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Uday Kumar',
                  style: AppTextStyles.s18SemiBold.copyWith(color: colors.onSurface),
                ),
                const SizedBox(height: 3),
                Text(
                  'udaykumar@leadrat.com',
                  style: AppTextStyles.s11Regular.copyWith(color: colors.onSurfaceDim),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _StatusChip(label: 'Verified', icon: Icons.verified_rounded, color: ColorPalette.primaryTeal),
                    const SizedBox(width: 8),
                    _StatusChip(label: 'Owner', icon: Icons.apartment_rounded, color: ColorPalette.warningAmber),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    final colors = context.colors;
    const stats = [
      _Stat(label: 'Since', value: '2023', icon: Icons.access_time_rounded),
      _Stat(label: 'Tickets', value: '4', icon: Icons.support_agent_outlined),
      _Stat(label: 'Documents', value: '12', icon: Icons.folder_outlined),
    ];
    return Row(
      children: List.generate(stats.length, (i) {
        final stat = stats[i];
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < stats.length - 1 ? 10 : 0),
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: colors.surfaceContainer,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(stat.icon, size: 18, color: colors.primaryTeal),
                const SizedBox(height: 6),
                Text(stat.value, style: AppTextStyles.s16SemiBold.copyWith(color: colors.onSurface)),
                const SizedBox(height: 2),
                Text(
                  stat.label,
                  style: AppTextStyles.s9Regular.copyWith(color: colors.onSurfaceDim),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    final colors = context.colors;
    return Text(
      label.toUpperCase(),
      style: AppTextStyles.s11SemiBold.copyWith(color: colors.onSurfaceDim, letterSpacing: 1.0),
    );
  }

  Widget _buildGroup(BuildContext context, List<_InfoRow> rows) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15), width: 1),
      ),
      child: Column(
        children: List.generate(rows.length, (i) {
          final isLast = i == rows.length - 1;
          return Column(
            children: [
              _InfoRowTile(row: rows[i]),
              if (!isLast)
                Divider(height: 1, indent: 56, color: colors.outlineVariant.withValues(alpha: 0.15)),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildPreferencesCard(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15), width: 1),
      ),
      child: Column(
        children: [
          const _NotificationToggleTile(),
          Divider(height: 1, indent: 56, color: colors.outlineVariant.withValues(alpha: 0.15)),
          const _InfoRowTile(
            row: _InfoRow(icon: Icons.language_rounded, label: 'Language', value: 'English', editable: true),
          ),
          Divider(height: 1, indent: 56, color: colors.outlineVariant.withValues(alpha: 0.15)),
          const _InfoRowTile(
            row: _InfoRow(icon: Icons.security_outlined, label: 'Privacy & Data', value: 'Manage', editable: true),
          ),
        ],
      ),
    );
  }
}

// ── Data models ───────────────────────────────────────────────────────────────

class _Stat {
  final String label;
  final String value;
  final IconData icon;
  const _Stat({required this.label, required this.value, required this.icon});
}

class _InfoRow {
  final IconData icon;
  final String label;
  final String value;
  final bool editable;
  const _InfoRow({required this.icon, required this.label, required this.value, this.editable = false});
}

// ── Widgets ───────────────────────────────────────────────────────────────────

class _StatusChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _StatusChip({required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.s9SemiBold.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _InfoRowTile extends StatelessWidget {
  final _InfoRow row;
  const _InfoRowTile({required this.row});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(row.icon, size: 18, color: colors.primaryTealFixedDim),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(row.label, style: AppTextStyles.s11Regular.copyWith(color: colors.onSurfaceDim)),
                const SizedBox(height: 2),
                Text(row.value, style: AppTextStyles.s14Medium.copyWith(color: colors.onSurface)),
              ],
            ),
          ),
          if (row.editable) Icon(Icons.chevron_right, size: 18, color: colors.onSurfaceDim),
        ],
      ),
    );
  }
}

class _NotificationToggleTile extends StatefulWidget {
  const _NotificationToggleTile();

  @override
  State<_NotificationToggleTile> createState() => _NotificationToggleTileState();
}

class _NotificationToggleTileState extends State<_NotificationToggleTile> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.notifications_outlined, size: 18, color: colors.primaryTealFixedDim),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Notifications', style: AppTextStyles.s14Medium.copyWith(color: colors.onSurface)),
                const SizedBox(height: 2),
                Text(
                  _enabled ? 'Alerts & reminders on' : 'All notifications off',
                  style: AppTextStyles.s11Regular.copyWith(color: colors.onSurfaceDim),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: _enabled,
            onChanged: (v) => setState(() => _enabled = v),
            activeThumbColor: colors.primaryTeal,
            activeTrackColor: colors.primaryTeal.withValues(alpha: 0.25),
          ),
        ],
      ),
    );
  }
}
