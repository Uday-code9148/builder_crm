import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateful_widget.dart';
import 'package:temp_architecture_app_setup/core/common/constants/app_display_constants.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/common_more_widget.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/curator_glass_app_bar.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/enums/data_status.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:temp_architecture_app_setup/features/dashboard/presentation/helpers/dashboard_navigation_mapper.dart';
import 'package:temp_architecture_app_setup/features/dashboard/presentation/helpers/dashboard_view_model.dart';
import 'package:temp_architecture_app_setup/features/dashboard/presentation/widgets/dashboard_loading_skeleton_sliver.dart';

class DashboardPage extends BaseStatefulWidget {
  final ValueChanged<int>? onNavigateToTab;
  final String headerTitle;
  final String headerSubtitle;

  const DashboardPage({
    super.key,
    this.onNavigateToTab,
    this.headerTitle = AppDisplayConstants.appTitle,
    this.headerSubtitle = AppDisplayConstants.unitLabel,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends BaseState<DashboardPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late final AnimationController _progressCtrl;
  late final Animation<double> _progressAnim;

  @override
  void onInit() {
    _progressCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..forward();
    _progressAnim = CurvedAnimation(parent: _progressCtrl, curve: const Cubic(0.2, 0.8, 0.2, 1));
  }

  @override
  void onDispose() {
    _progressCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildContent(context);
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DashboardBloc>()..add(DashboardLoadRequested()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          final colors = context.colors;
          return Scaffold(
            backgroundColor: colors.surface,
            appBar: buildCuratorGlassAppBar(
              context: context,
              title: state.selectedTitle,
              subtitle: state.selectedSubtitle,
              projectWidget: CommonMoreWidget(
                triggerIcon: Icons.home_work_rounded,
                items: state.viewModel?.projectMenuItems ?? const [],
                onSelected: (item) {
                  if (item.subtitle != null) {
                    context.read<DashboardBloc>().add(DashboardPropertySelected(title: item.title, subtitle: item.subtitle!));
                  }
                },
              ),
            ),
            body: RefreshIndicator(
              color: colors.primaryTeal,
              notificationPredicate: (n) => n.depth == 0,
              onRefresh: () async {
                final bloc = context.read<DashboardBloc>();
                bloc.add(DashboardLoadRequested());
                try {
                  await bloc.stream.firstWhere((s) => s.status != DataStatus.loading).timeout(const Duration(seconds: 12));
                } catch (_) {}
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  if (state.status == DataStatus.loading)
                    const DashboardLoadingSkeletonSliver()
                  else if (state.status == DataStatus.error)
                    SliverFillRemaining(
                      child: Center(
                        child: Text(state.error ?? 'Something went wrong', style: AppTextStyles.s13Regular.copyWith(color: colors.onSurfaceVariant)),
                      ),
                    )
                  else if (state.viewModel != null)
                    _buildContent(context, state.viewModel!)
                  else
                    const SliverToBoxAdapter(child: SizedBox.shrink()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, DashboardViewModel vm) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          const SizedBox(height: 24),
          _buildGreeting(vm.greeting),
          const SizedBox(height: 16),
          if (vm.alert != null) ...[_buildAlertCard(vm.alert!), const SizedBox(height: 16)],
          _buildPaymentSnapshot(vm.paymentSnapshot),
          const SizedBox(height: 16),
          _buildQuickActions(),
          const SizedBox(height: 16),
          _buildConstructionCard(vm.construction),
          const SizedBox(height: 16),
          _buildUnitSummary(vm.unitInfo),
          const SizedBox(height: 16),
          _buildRecentActivity(vm.activities),
        ]),
      ),
    );
  }

  Widget _buildGreeting(String greeting) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(greeting, style: AppTextStyles.s22SemiBold.copyWith(color: colors.onSurface)),
        const SizedBox(height: 4),
        Text('Welcome back to your portfolio overview.', style: AppTextStyles.s13Regular.copyWith(color: colors.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildAlertCard(DashboardAlertVM alert) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.warningContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.warningAmber.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: colors.warningAmber.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.warning_amber_rounded, color: colors.warningAmber, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(alert.title, style: AppTextStyles.s12SemiBold.copyWith(color: colors.onWarningContainer)),
                const SizedBox(height: 2),
                Text(alert.subtitle, style: AppTextStyles.s11Regular.copyWith(color: colors.onWarningContainer.withValues(alpha: 0.7))),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: colors.primaryTeal.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.primaryTeal.withValues(alpha: 0.4)),
            ),
            child: Text('Pay Now', style: AppTextStyles.s11SemiBold.copyWith(color: colors.primaryTeal)),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSnapshot(DashboardPaymentVM snapshot) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment SnapShot', style: AppTextStyles.s14SemiBold.copyWith(color: colors.onSurface)),
          const SizedBox(height: 14),
          Row(
            children: [
              SizedBox(
                width: 88,
                height: 88,
                child: AnimatedBuilder(
                  animation: _progressAnim,
                  builder: (_, _) {
                    final value = snapshot.progressPercent * _progressAnim.value;
                    final pct = (snapshot.progressPercent * 100 * _progressAnim.value).toInt();
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(value: 1, strokeWidth: 8, valueColor: AlwaysStoppedAnimation(colors.surfaceContainerHigh)),
                        CircularProgressIndicator(value: value, strokeWidth: 8, valueColor: AlwaysStoppedAnimation(colors.primaryTeal)),
                        Center(child: Text('$pct%', style: AppTextStyles.s16SemiBold.copyWith(color: colors.onSurface))),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_row('TOTAL PAID', snapshot.totalPaid), _row('NEXT DUE', snapshot.nextDue), _row('BALANCE', snapshot.balance)],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(String k, String v) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(child: Text(k, style: AppTextStyles.s10Regular.copyWith(color: colors.onSurfaceDim))),
          Text(v, style: AppTextStyles.s12SemiBold.copyWith(color: colors.onSurface)),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final colors = context.colors;
    const actions = [
      (ImageResources.icPayments, 'Payments'),
      (ImageResources.icDocuments, 'Documents'),
      (ImageResources.icSupport, 'Support'),
      (ImageResources.icStatement, 'Statement'),
    ];

    return Row(
      children: List.generate(actions.length, (i) {
        final a = actions[i];
        final targetTab = DashboardNavigationMapper.tabIndexForQuickAction(a.$2);
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i == actions.length - 1 ? 0 : 8),
            child: GestureDetector(
              onTap: targetTab == null ? null : () => widget.onNavigateToTab?.call(targetTab),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: colors.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15)),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(a.$1, width: 20, height: 20),
                    const SizedBox(height: 8),
                    Text(a.$2, style: AppTextStyles.s10Medium.copyWith(color: colors.onSurfaceVariant)),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildConstructionCard(DashboardConstructionVM construction) {
    final colors = context.colors;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 148,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF0E2B1E), Color(0xFF1A4530), Color(0xFF122B1F)],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Opacity(opacity: 0.25, child: Icon(Icons.forest, size: 160, color: colors.primaryTeal)),
                ),
                Positioned(
                  bottom: 0,
                  right: 12,
                  child: Opacity(opacity: 0.15, child: const Icon(Icons.apartment, size: 120, color: ColorPalette.primaryTealFixed)),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: colors.onPrimaryTeal.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: colors.white.withValues(alpha: 0.12)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on_outlined, size: 12, color: colors.primaryTeal),
                        const SizedBox(width: 4),
                        Text('Construction Milestone', style: AppTextStyles.s10Medium.copyWith(color: colors.onSurface)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text('Project Completion', style: AppTextStyles.s13Medium.copyWith(color: colors.onSurface))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                      decoration: BoxDecoration(color: colors.primaryTeal.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(6)),
                      child: Text(construction.progressLabel, style: AppTextStyles.s11SemiBold.copyWith(color: colors.primaryTeal)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: construction.progressPercent,
                    backgroundColor: colors.surfaceContainerHigh,
                    valueColor: AlwaysStoppedAnimation(colors.primaryTeal),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitSummary(DashboardUnitVM unit) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Unit Summary', style: AppTextStyles.s14SemiBold.copyWith(color: colors.onSurface)),
          const SizedBox(height: 14),
          _unitRow('Configuration', unit.configuration),
          const SizedBox(height: 10),
          _unitRow('Cover Area', unit.coverArea),
          const SizedBox(height: 10),
          _unitRow('Floor / Wing', unit.floorWing),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.primaryTeal,
                side: BorderSide(color: colors.primaryTeal.withValues(alpha: 0.5)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.zero,
              ),
              child: Text('View Floor Plan', style: AppTextStyles.s13Medium.copyWith(color: colors.primaryTeal)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _unitRow(String label, String value) {
    final colors = context.colors;
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTextStyles.s12Regular.copyWith(color: colors.onSurfaceDim))),
        Text(value, style: AppTextStyles.s12SemiBold.copyWith(color: colors.onSurface)),
      ],
    );
  }

  Widget _buildRecentActivity(List<DashboardActivityVM> activities) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Activity', style: AppTextStyles.s14SemiBold.copyWith(color: colors.onSurface)),
          const SizedBox(height: 14),
          ...List.generate(activities.length, (i) {
            final a = activities[i];
            return Column(
              children: [
                if (i > 0) ...[Divider(height: 1, color: colors.outlineVariant.withValues(alpha: 0.2)), const SizedBox(height: 12)],
                _activityItem(a),
                if (i < activities.length - 1) const SizedBox(height: 12),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _activityItem(DashboardActivityVM item) {
    final colors = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(color: colors.surfaceContainerHigh, borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset(item.iconAsset),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: AppTextStyles.s12SemiBold.copyWith(color: colors.onSurface)),
              const SizedBox(height: 3),
              Text(item.subtitle, style: AppTextStyles.s11Regular.copyWith(color: colors.onSurfaceDim), maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(item.timeLabel, style: AppTextStyles.s10Regular.copyWith(color: colors.onSurfaceDim)),
      ],
    );
  }
}
