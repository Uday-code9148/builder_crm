import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/core/router/app_routes.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/sign_out/sign_out_cubit.dart';
import 'package:temp_architecture_app_setup/features/documents/presentation/pages/documents_page.dart';
import 'package:temp_architecture_app_setup/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:temp_architecture_app_setup/features/payments/presentation/pages/payments_page.dart';
import 'package:temp_architecture_app_setup/features/support/presentation/pages/support_page.dart';
import 'package:temp_architecture_app_setup/features/updates/presentation/pages/updates_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignOutCubit>(),
      child: const _HomeShell(),
    );
  }
}

class _HomeShell extends StatefulWidget {
  const _HomeShell();

  @override
  State<_HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<_HomeShell> {
  int _currentIndex = 0;

  static const _tabs = [
    _TabItem(label: 'Home',      asset: ImageResources.icHome),
    _TabItem(label: 'Payments',  asset: ImageResources.icPayments),
    _TabItem(label: 'Documents', asset: ImageResources.icDocuments),
    _TabItem(label: 'Tickets',   asset: ImageResources.icUpdates),
    _TabItem(label: 'More',      asset: ImageResources.icMore),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignOutCubit, SignOutState>(
      listenWhen: (prev, curr) => !prev.canGoLogin && curr.canGoLogin,
      listener: (context, state) => context.go(Routes.login),
      child: Scaffold(
        backgroundColor: ColorPalette.surface,
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            DashboardPage(),
            PaymentsPage(),
            DocumentsPage(),
            SupportPage(),
            _MorePage(),
          ],
        ),
        bottomNavigationBar: _ArchBottomNav(
          currentIndex: _currentIndex,
          tabs: _tabs,
          onTap: (i) => setState(() => _currentIndex = i),
        ),
      ),
    );
  }
}

class _TabItem {
  final String label;
  final String asset;
  const _TabItem({required this.label, required this.asset});
}

class _ArchBottomNav extends StatelessWidget {
  final int currentIndex;
  final List<_TabItem> tabs;
  final ValueChanged<int> onTap;

  const _ArchBottomNav({
    required this.currentIndex,
    required this.tabs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.surfaceContainerLow,
        border: Border(
          top: BorderSide(
            color: ColorPalette.outlineVariant.withValues(alpha: 0.25),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(tabs.length, (i) {
              final tab = tabs[i];
              final selected = i == currentIndex;
              final iconColor =
                  selected ? ColorPalette.primaryTeal : ColorPalette.onSurfaceDim;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: SvgPicture.asset(
                            tab.asset,
                            key: ValueKey('${tab.asset}_$selected'),
                            width: 22,
                            height: 22,
                            colorFilter: ColorFilter.mode(
                              iconColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          tab.label,
                          style: AppTextStyles.s10Regular.copyWith(
                            color: iconColor,
                            fontWeight: selected
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
// ─── More tab ─────────────────────────────────────────────────────────────────
class _MorePage extends StatelessWidget {
  const _MorePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.surface,
      appBar: _buildAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 20),
                _buildProjectCard(),
                const SizedBox(height: 28),
                _buildSectionLabel('Property'),
                const SizedBox(height: 10),
                _buildGroup([
                  _MoreOption(
                    icon: Icons.architecture_rounded,
                    label: 'Milestones',
                    subtitle: 'Track construction progress',
                    badge: '65%',
                    badgeColor: ColorPalette.warningAmber,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const UpdatesPage()),
                    ),
                  ),
                  _MoreOption(
                    icon: Icons.photo_library_outlined,
                    label: 'Site Photos',
                    subtitle: 'Latest 12 photos uploaded',
                  ),
                  _MoreOption(
                    icon: Icons.receipt_long_outlined,
                    label: 'Payment Schedule',
                    subtitle: 'View full payment plan',
                  ),
                ]),
                const SizedBox(height: 24),
                _buildSectionLabel('Account'),
                const SizedBox(height: 10),
                _buildGroup([
                  _MoreOption(
                    icon: Icons.person_outline_rounded,
                    label: 'My Profile',
                    subtitle: 'Name, contact & preferences',
                  ),
                  _MoreOption(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    subtitle: 'Manage alerts & reminders',
                  ),
                  _MoreOption(
                    icon: Icons.lock_outline_rounded,
                    label: 'Security',
                    subtitle: 'Password & biometrics',
                  ),
                  _MoreOption(
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
                        color: ColorPalette.errorContainer,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: ColorPalette.errorDeep.withValues(alpha: 0.3),
                            width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout_rounded,
                              size: 18, color: ColorPalette.errorDeep),
                          const SizedBox(width: 10),
                          Text('Sign Out',
                              style: AppTextStyles.s14Medium
                                  .copyWith(color: ColorPalette.errorDeep)),
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

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 64,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            decoration: BoxDecoration(
              color: ColorPalette.surface.withValues(alpha: 0.92),
              border: Border(
                bottom: BorderSide(
                  color: ColorPalette.outlineVariant.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          const SizedBox(width: 20),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: ColorPalette.primaryTealFixed,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: ColorPalette.onPrimaryTeal.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.home_work_rounded, size: 18, color: ColorPalette.white),
          ),
          const SizedBox(width: 10),
          Text('Architectural Curator',
              style: AppTextStyles.s13SemiBold.copyWith(color: ColorPalette.onSurface)),
          const Spacer(),
          const Icon(Icons.swap_horiz_rounded, color: ColorPalette.onSurfaceVariant, size: 20),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildProjectCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorPalette.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: ColorPalette.outlineVariant.withValues(alpha: 0.15), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: ColorPalette.primaryTeal.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.apartment_rounded,
                size: 22, color: ColorPalette.primaryTeal),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('The Emerald Pavilion',
                    style: AppTextStyles.s14SemiBold
                        .copyWith(color: ColorPalette.onSurface)),
                const SizedBox(height: 2),
                Text('UNIT 402 · SKY-VILLA · PHASE II',
                    style: AppTextStyles.s10Regular.copyWith(
                        color: ColorPalette.onSurfaceDim, letterSpacing: 1.1)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: ColorPalette.primaryTeal.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text('65%',
                style: AppTextStyles.s11SemiBold
                    .copyWith(color: ColorPalette.primaryTeal)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(label,
        style: AppTextStyles.s11SemiBold.copyWith(
            color: ColorPalette.onSurfaceDim, letterSpacing: 1.0));
  }

  Widget _buildGroup(List<_MoreOption> options) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: ColorPalette.outlineVariant.withValues(alpha: 0.15), width: 1),
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
                  color: ColorPalette.outlineVariant.withValues(alpha: 0.15),
                ),
            ],
          );
        }),
      ),
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

class _MoreOptionTile extends StatelessWidget {
  final _MoreOption option;
  const _MoreOptionTile({required this.option});

  @override
  Widget build(BuildContext context) {
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
              color: ColorPalette.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(option.icon, size: 18, color: ColorPalette.primaryTealFixedDim),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(option.label,
                    style: AppTextStyles.s14Medium
                        .copyWith(color: ColorPalette.onSurface)),
                const SizedBox(height: 1),
                Text(option.subtitle,
                    style: AppTextStyles.s11Regular
                        .copyWith(color: ColorPalette.onSurfaceDim)),
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
              child: Text(option.badge!,
                  style: AppTextStyles.s10SemiBold
                      .copyWith(color: option.badgeColor)),
            ),
            const SizedBox(width: 8),
          ],
          const Icon(Icons.chevron_right, size: 18, color: ColorPalette.onSurfaceDim),
        ],
      ),
    ));
  }
}

