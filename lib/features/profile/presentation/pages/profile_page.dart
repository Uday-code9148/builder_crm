import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateless_widget.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/curator_glass_app_bar.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:temp_architecture_app_setup/features/profile/presentation/helpers/profile_view_model.dart';

class ProfilePage extends BaseStatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(ProfileLoadRequested()),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends BaseStatelessWidget {
  const _ProfileView();

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
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) => switch (state.status) {
          ProfileStatus.initial || ProfileStatus.loading => const _LoadingView(),
          ProfileStatus.error => _ErrorView(
              message: state.errorMessage ?? 'Failed to load profile.',
              onRetry: () => context.read<ProfileBloc>().add(ProfileLoadRequested()),
            ),
          ProfileStatus.loaded => _ProfileContent(vm: state.viewModel!),
        },
      ),
    );
  }
}

// ── Loading ───────────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(strokeWidth: 2.5, color: context.colors.primaryTeal));
  }
}

// ── Error ─────────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 48, color: colors.errorDeep),
            const SizedBox(height: 14),
            Text(message, textAlign: TextAlign.center, style: AppTextStyles.s14Regular.copyWith(color: colors.onSurfaceVariant)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 16),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryTeal,
                foregroundColor: colors.onPrimaryTeal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Content ───────────────────────────────────────────────────────────────────

class _ProfileContent extends StatelessWidget {
  final ProfileViewModel vm;
  const _ProfileContent({required this.vm});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<ProfileBloc>().add(ProfileLoadRequested()),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 24),
                _AvatarCard(initials: vm.initials, name: vm.displayName, email: vm.displayEmail),
                const SizedBox(height: 20),
                _StatsRow(memberSince: vm.memberSince, tickets: vm.ticketsCount, documents: vm.documentsCount),
                const SizedBox(height: 28),
                const _SectionLabel(label: 'Account'),
                const SizedBox(height: 10),
                _InfoGroup(rows: [
                  _InfoRow(icon: Icons.person_outline_rounded, label: 'Full Name', value: vm.displayName, editable: true),
                  _InfoRow(icon: Icons.email_outlined, label: 'Email', value: vm.displayEmail, editable: true),
                  _InfoRow(icon: Icons.phone_outlined, label: 'Phone', value: vm.displayPhone, editable: true),
                  _InfoRow(icon: Icons.cake_outlined, label: 'Date of Birth', value: vm.displayDob, editable: true),
                ]),
                const SizedBox(height: 24),
                const _SectionLabel(label: 'Property Details'),
                const SizedBox(height: 10),
                _InfoGroup(rows: [
                  _InfoRow(icon: Icons.apartment_rounded, label: 'Project', value: vm.projectName),
                  _InfoRow(icon: Icons.home_work_outlined, label: 'Unit', value: vm.unit),
                  _InfoRow(icon: Icons.layers_outlined, label: 'Phase', value: vm.phase),
                  _InfoRow(icon: Icons.calendar_today_outlined, label: 'Booking Date', value: vm.bookingDate),
                ]),
                const SizedBox(height: 24),
                const _SectionLabel(label: 'Preferences'),
                const SizedBox(height: 10),
                const _PreferencesCard(),
                const SizedBox(height: 28),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Avatar card ───────────────────────────────────────────────────────────────

class _AvatarCard extends StatelessWidget {
  final String initials;
  final String name;
  final String email;
  const _AvatarCard({required this.initials, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
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
                  boxShadow: [BoxShadow(color: colors.primaryTeal.withValues(alpha: 0.3), blurRadius: 18, offset: const Offset(0, 6))],
                ),
                child: Center(
                  child: Text(initials, style: AppTextStyles.s18SemiBold.copyWith(color: colors.onPrimaryTeal, letterSpacing: 1.5)),
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
                Text(name, style: AppTextStyles.s18SemiBold.copyWith(color: colors.onSurface), overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Text(email, style: AppTextStyles.s11Regular.copyWith(color: colors.onSurfaceDim), overflow: TextOverflow.ellipsis),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _Chip(label: 'Verified', icon: Icons.verified_rounded, color: ColorPalette.primaryTeal),
                    const SizedBox(width: 8),
                    _Chip(label: 'Owner', icon: Icons.apartment_rounded, color: ColorPalette.warningAmber),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stats row ─────────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final String memberSince;
  final String tickets;
  final String documents;
  const _StatsRow({required this.memberSince, required this.tickets, required this.documents});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final stats = [
      (label: 'Since', value: memberSince, icon: Icons.access_time_rounded),
      (label: 'Tickets', value: tickets, icon: Icons.support_agent_outlined),
      (label: 'Documents', value: documents, icon: Icons.folder_outlined),
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
              children: [
                Icon(stat.icon, size: 18, color: colors.primaryTeal),
                const SizedBox(height: 6),
                Text(stat.value, style: AppTextStyles.s16SemiBold.copyWith(color: colors.onSurface)),
                const SizedBox(height: 2),
                Text(stat.label, style: AppTextStyles.s9Regular.copyWith(color: colors.onSurfaceDim), textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// ── Section label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Text(label.toUpperCase(), style: AppTextStyles.s11SemiBold.copyWith(color: colors.onSurfaceDim, letterSpacing: 1.0));
  }
}

// ── Info group ────────────────────────────────────────────────────────────────

class _InfoRow {
  final IconData icon;
  final String label;
  final String value;
  final bool editable;
  const _InfoRow({required this.icon, required this.label, required this.value, this.editable = false});
}

class _InfoGroup extends StatelessWidget {
  final List<_InfoRow> rows;
  const _InfoGroup({required this.rows});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: List.generate(rows.length, (i) {
          final isLast = i == rows.length - 1;
          return Column(
            children: [
              _InfoRowTile(row: rows[i]),
              if (!isLast) Divider(height: 1, indent: 56, color: colors.outlineVariant.withValues(alpha: 0.15)),
            ],
          );
        }),
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
            decoration: BoxDecoration(color: colors.surfaceContainerHigh, borderRadius: BorderRadius.circular(10)),
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

// ── Preferences card ──────────────────────────────────────────────────────────

class _PreferencesCard extends StatefulWidget {
  const _PreferencesCard();

  @override
  State<_PreferencesCard> createState() => _PreferencesCardState();
}

class _PreferencesCardState extends State<_PreferencesCard> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(color: colors.surfaceContainerHigh, borderRadius: BorderRadius.circular(10)),
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
                        _notificationsEnabled ? 'Alerts & reminders on' : 'All notifications off',
                        style: AppTextStyles.s11Regular.copyWith(color: colors.onSurfaceDim),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: _notificationsEnabled,
                  onChanged: (v) => setState(() => _notificationsEnabled = v),
                  activeThumbColor: colors.primaryTeal,
                  activeTrackColor: colors.primaryTeal.withValues(alpha: 0.25),
                ),
              ],
            ),
          ),
          Divider(height: 1, indent: 56, color: colors.outlineVariant.withValues(alpha: 0.15)),
          const _InfoRowTile(row: _InfoRow(icon: Icons.language_rounded, label: 'Language', value: 'English', editable: true)),
          Divider(height: 1, indent: 56, color: colors.outlineVariant.withValues(alpha: 0.15)),
          const _InfoRowTile(row: _InfoRow(icon: Icons.security_outlined, label: 'Privacy & Data', value: 'Manage', editable: true)),
        ],
      ),
    );
  }
}

// ── Chip ──────────────────────────────────────────────────────────────────────

class _Chip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _Chip({required this.label, required this.icon, required this.color});

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
