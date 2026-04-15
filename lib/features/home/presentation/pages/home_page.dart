import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateful_widget.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateless_widget.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/enums/home_tab.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/core/router/app_routes.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/sign_out/sign_out_cubit.dart';
import 'package:temp_architecture_app_setup/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:temp_architecture_app_setup/features/documents/presentation/pages/documents_page.dart';
import 'package:temp_architecture_app_setup/features/more/presentation/pages/more_page.dart';
import 'package:temp_architecture_app_setup/features/payments/presentation/pages/payments_page.dart';
import 'package:temp_architecture_app_setup/features/support/presentation/pages/support_page.dart';

class HomePage extends BaseStatelessWidget {
  const HomePage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(create: (_) => getIt<SignOutCubit>(), child: const _HomeShell());
  }
}

class _HomeShell extends BaseStatefulWidget {
  const _HomeShell();

  @override
  State<_HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends BaseState<_HomeShell> {
  HomeTab _currentTab = HomeTab.home;

  @override
  Widget buildContent(BuildContext context) {
    return BlocListener<SignOutCubit, SignOutState>(
      listenWhen: (prev, curr) => !prev.canGoLogin && curr.canGoLogin,
      listener: (context, state) => context.go(Routes.login),
      child: Scaffold(
        backgroundColor: context.colors.surface,
        body: IndexedStack(
          index: _currentTab.index,
          children: [
            DashboardPage(onNavigateToTab: _onTabSelected),
            const PaymentsPage(),
            const DocumentsPage(),
            const SupportPage(),
            const MorePage(),
          ],
        ),
        bottomNavigationBar: _ArchBottomNav(currentTab: _currentTab, tabs: HomeTab.values, onTap: (tab) => setState(() => _currentTab = tab)),
      ),
    );
  }

  void _onTabSelected(int index) {
    final targetTab = HomeTab.values[index];
    if (_currentTab == targetTab) {
      return;
    }
    setState(() => _currentTab = targetTab);
  }
}

class _ArchBottomNav extends BaseStatelessWidget {
  final HomeTab currentTab;
  final List<HomeTab> tabs;
  final ValueChanged<HomeTab> onTap;

  const _ArchBottomNav({required this.currentTab, required this.tabs, required this.onTap});

  @override
  Widget buildContent(BuildContext context) {
    final colors = context.colors;
    return Container(
      color: colors.surface,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: colors.onSurface.withValues(alpha: 0.06), blurRadius: 18, offset: const Offset(0, -2))],
          border: Border(top: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.25), width: 1)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 80,
            child: Row(
              children: List.generate(tabs.length, (i) {
                final tab = tabs[i];
                final selected = tab == currentTab;
                final iconColor = selected ? colors.primaryTeal : colors.onSurfaceDim;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(tab),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 240),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 9),
                      decoration: BoxDecoration(
                        color: selected ? colors.primaryTeal.withValues(alpha: 0.12) : ColorPalette.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: SvgPicture.asset(
                              tab.asset,
                              key: ValueKey('${tab.asset}_$selected'),
                              width: 25,
                              height: 25,
                              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                            ),
                          ),
                          const SizedBox(height: 6),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                            style: AppTextStyles.s10Regular.copyWith(color: iconColor, fontWeight: selected ? FontWeight.w600 : FontWeight.w400),
                            child: Text(tab.label),
                          ),
                          const SizedBox(height: 4),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            curve: Curves.easeOut,
                            width: selected ? 18 : 0,
                            height: 2.4,
                            decoration: BoxDecoration(color: colors.primaryTeal, borderRadius: BorderRadius.circular(99)),
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
      ),
    );
  }
}
