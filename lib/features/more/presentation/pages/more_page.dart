import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateless_widget.dart';
import 'package:temp_architecture_app_setup/core/common/constants/app_display_constants.dart';
import 'package:temp_architecture_app_setup/core/enums/app_sub_page.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/curator_glass_app_bar.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/core/theme/cubit/theme_cubit.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/sign_out/sign_out_cubit.dart';

class MorePage extends BaseStatelessWidget {
  final String headerTitle;
  final String? headerSubtitle;
  final String projectName;
  final String projectUnitPhase;
  final void Function(AppSubPage page)? onNavigateTo;

  const MorePage({
    super.key,
    this.headerTitle = AppDisplayConstants.appTitle,
    this.headerSubtitle,
    this.projectName = AppDisplayConstants.projectName,
    this.projectUnitPhase = AppDisplayConstants.projectUnitPhase,
    this.onNavigateTo,
  });

  @override
  Widget buildContent(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.surface,
      appBar: _buildAppBar(context),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 20),
                _buildProjectCard(context),
                const SizedBox(height: 28),
                _buildSectionLabel(context, 'Property'),
                const SizedBox(height: 10),
                _buildGroup(context, [
                  _MoreOption(
                    icon: Icons.architecture_rounded,
                    label: 'Milestones',
                    subtitle: 'Track construction progress',
                    badge: '65%',
                    badgeColor: ColorPalette.warningAmber,
                    onTap: () => onNavigateTo?.call(AppSubPage.milestones),
                  ),
                  const _MoreOption(
                    icon: Icons.photo_library_outlined,
                    label: 'Site Photos',
                    subtitle: 'Latest 12 photos uploaded',
                  ),
                  const _MoreOption(
                    icon: Icons.receipt_long_outlined,
                    label: 'Payment Schedule',
                    subtitle: 'View full payment plan',
                  ),
                ]),
                const SizedBox(height: 24),
                _buildSectionLabel(context, 'Account'),
                const SizedBox(height: 10),
                _buildGroup(context, [
                  _MoreOption(
                    icon: Icons.person_outline_rounded,
                    label: 'My Profile',
                    subtitle: 'Name, contact & preferences',
                    onTap: () => onNavigateTo?.call(AppSubPage.profile),
                  ),
                  const _MoreOption(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    subtitle: 'Manage alerts & reminders',
                  ),
                  const _MoreOption(
                    icon: Icons.lock_outline_rounded,
                    label: 'Security',
                    subtitle: 'Password & biometrics',
                  ),
                  _MoreOption(
                    icon: Icons.palette_outlined,
                    label: 'Appearance',
                    subtitle: 'Light, Dark, or System theme',
                    onTap: () => _showThemePicker(context),
                  ),
                  const _MoreOption(
                    icon: Icons.help_outline_rounded,
                    label: 'Help & Support',
                    subtitle: 'FAQs, contact us',
                  ),
                ]),
                const SizedBox(height: 28),
                BlocBuilder<SignOutCubit, SignOutState>(
                  builder: (context, _) => GestureDetector(
                    onTap: () => context.read<SignOutCubit>().signOut(),
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: colors.errorContainer,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colors.errorDeep.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout_rounded, size: 18, color: colors.errorDeep),
                          const SizedBox(width: 10),
                          Text(
                            'Sign Out',
                            style: AppTextStyles.s14Medium.copyWith(color: colors.errorDeep),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return buildCuratorGlassAppBar(
      context: context,
      title: headerTitle,
      subtitle: headerSubtitle,
    );
  }

  Widget _buildProjectCard(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colors.primaryTeal.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.apartment_rounded, size: 22, color: colors.primaryTeal),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  projectName,
                  style: AppTextStyles.s14SemiBold.copyWith(color: colors.onSurface),
                ),
                const SizedBox(height: 2),
                Text(
                  projectUnitPhase,
                  style: AppTextStyles.s10Regular.copyWith(color: colors.onSurfaceDim, letterSpacing: 1.1),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: colors.primaryTeal.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text('65%', style: AppTextStyles.s11SemiBold.copyWith(color: colors.primaryTeal)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    final colors = context.colors;
    return Text(
      label,
      style: AppTextStyles.s11SemiBold.copyWith(color: colors.onSurfaceDim, letterSpacing: 1.0),
    );
  }

  Widget _buildGroup(BuildContext context, List<_MoreOption> options) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15), width: 1),
      ),
      child: Column(
        children: List.generate(options.length, (i) {
          final opt = options[i];
          final isLast = i == options.length - 1;
          return Column(
            children: [
              _MoreOptionTile(option: opt),
              if (!isLast)
                Divider(
                  height: 1,
                  indent: 56,
                  color: colors.outlineVariant.withValues(alpha: 0.15),
                ),
            ],
          );
        }),
      ),
    );
  }

  void _showThemePicker(BuildContext context) {
    final colors = context.colors;
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _ThemePickerSheet(),
    );
  }
}

class _MoreOption {
  final IconData icon;
  final String label;
  final String subtitle;
  final String? badge;
  final Color? badgeColor;
  final VoidCallback? onTap;

  const _MoreOption({
    required this.icon,
    required this.label,
    required this.subtitle,
    this.badge,
    this.badgeColor,
    this.onTap,
  });
}

class _MoreOptionTile extends BaseStatelessWidget {
  final _MoreOption option;
  const _MoreOptionTile({required this.option});

  @override
  Widget buildContent(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: option.onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
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
              child: Icon(option.icon, size: 18, color: colors.primaryTealFixedDim),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(option.label, style: AppTextStyles.s14Medium.copyWith(color: colors.onSurface)),
                  const SizedBox(height: 1),
                  Text(option.subtitle, style: AppTextStyles.s11Regular.copyWith(color: colors.onSurfaceDim)),
                ],
              ),
            ),
            if (option.badge != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: option.badgeColor!.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(option.badge!, style: AppTextStyles.s10SemiBold.copyWith(color: option.badgeColor)),
              ),
              const SizedBox(width: 8),
            ],
            Icon(Icons.chevron_right, size: 18, color: colors.onSurfaceDim),
          ],
        ),
      ),
    );
  }
}

class _ThemePickerSheet extends BaseStatelessWidget {
  const _ThemePickerSheet();

  @override
  Widget buildContent(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: getIt<ThemeCubit>(),
      builder: (context, state) {
        final colors = context.colors;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colors.outlineVariant,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Appearance', style: AppTextStyles.s14SemiBold.copyWith(color: colors.onSurface)),
                const SizedBox(height: 14),
                _ThemeOption(
                  icon: Icons.light_mode_outlined,
                  label: 'Light',
                  selected: state.themeMode == ThemeMode.light,
                  onTap: () {
                    getIt<ThemeCubit>().setTheme(ThemeMode.light);
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 8),
                _ThemeOption(
                  icon: Icons.dark_mode_outlined,
                  label: 'Dark',
                  selected: state.themeMode == ThemeMode.dark,
                  onTap: () {
                    getIt<ThemeCubit>().setTheme(ThemeMode.dark);
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 8),
                _ThemeOption(
                  icon: Icons.brightness_auto_outlined,
                  label: 'System default',
                  selected: state.themeMode == ThemeMode.system,
                  onTap: () {
                    getIt<ThemeCubit>().setTheme(ThemeMode.system);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ThemeOption extends BaseStatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget buildContent(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? colors.primaryTeal.withValues(alpha: 0.08) : colors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? colors.primaryTeal.withValues(alpha: 0.45)
                : colors.outlineVariant.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: selected ? colors.primaryTeal : colors.onSurfaceVariant),
            const SizedBox(width: 14),
            Text(
              label,
              style: AppTextStyles.s14Medium.copyWith(
                color: selected ? colors.primaryTeal : colors.onSurface,
              ),
            ),
            const Spacer(),
            if (selected) Icon(Icons.check_circle_rounded, size: 18, color: colors.primaryTeal),
          ],
        ),
      ),
    );
  }
}
