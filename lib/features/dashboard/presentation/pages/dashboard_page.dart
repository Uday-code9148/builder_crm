import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateful_widget.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/features/dashboard/domain/entities/dashboard_data.dart';
import 'package:temp_architecture_app_setup/features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:temp_architecture_app_setup/features/dashboard/presentation/widgets/more_menu_widget.dart';

class DashboardPage extends BaseStatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends BaseState<DashboardPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late final AnimationController _progressCtrl;
  late final Animation<double> _progressAnim;
  final _scrollCtrl = ScrollController();
  double _scrollOffset = 0;

  @override
  void onInit() {
    _progressCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..forward();
    _progressAnim = CurvedAnimation(parent: _progressCtrl, curve: const Cubic(0.2, 0.8, 0.2, 1));
    _scrollCtrl.addListener(() => setState(() => _scrollOffset = _scrollCtrl.offset));
  }

  @override
  void onDispose() {
    _progressCtrl.dispose();
    _scrollCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // required by AutomaticKeepAliveClientMixin
    return buildContent(context);
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DashboardBloc>()..add(DashboardLoadRequested()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.colors.surface,
            body: CustomScrollView(
              controller: _scrollCtrl,
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildGlassAppBar(_scrollOffset),
                if (state.status == DataStatus.loading)
                  SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator(color: context.colors.primaryTeal, strokeWidth: 2)),
                  )
                else if (state.status == DataStatus.error)
                  SliverFillRemaining(
                    child: Center(
                      child: Text(
                        state.error ?? 'Something went wrong',
                        style: AppTextStyles.s13Regular.copyWith(color: context.colors.onSurfaceVariant),
                      ),
                    ),
                  )
                else if (state.data != null)
                  _buildContent(context, state.data!)
                else
                  const SliverToBoxAdapter(child: SizedBox.shrink()),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGlassAppBar(double scrollOffset) {
    final colors = context.colors;
    final scrolled = scrollOffset > 8;
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 64,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: scrolled ? 16 : 0, sigmaY: scrolled ? 16 : 0),
          child: Container(
            decoration: BoxDecoration(
              color: colors.surface.withValues(alpha: scrolled ? 0.92 : 1.0),
              border: scrolled ? Border(bottom: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.3))) : null,
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(right: 40, left: 20),
                child: Row(
                  children: [
                    const MoreMenuWidget(),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Architectural Curator', style: AppTextStyles.s13SemiBold.copyWith(color: colors.onSurface)),
                        Text('UNIT 402 · SKY-VILLA', style: AppTextStyles.s9Regular.copyWith(color: colors.onSurfaceDim, letterSpacing: 1.2)),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(onTap: () {}, child: SvgPicture.asset(ImageResources.icSwitchAccount)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DashboardData data) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          const SizedBox(height: 24),
          _buildGreeting(data),
          const SizedBox(height: 16),
          if (data.alert != null) ...[_buildAlertCard(data.alert!), const SizedBox(height: 16)],
          _buildPaymentSnapshot(data.paymentSnapshot),
          const SizedBox(height: 16),
          _buildQuickActions(),
          const SizedBox(height: 16),
          _buildConstructionCard(data.construction),
          const SizedBox(height: 16),
          _buildUnitSummary(data.unitInfo),
          const SizedBox(height: 16),
          _buildRecentActivity(data.recentActivities),
        ]),
      ),
    );
  }

  Widget _buildGreeting(DashboardData data) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(data.greeting, style: AppTextStyles.s22SemiBold.copyWith(color: colors.onSurface)),
        const SizedBox(height: 4),
        Text('Welcome back to your portfolio overview.', style: AppTextStyles.s13Regular.copyWith(color: colors.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildAlertCard(AlertInfo alert) {
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

  Widget _buildPaymentSnapshot(PaymentSnapshot snapshot) {
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
                        Center(
                          child: Text('$pct%', style: AppTextStyles.s16SemiBold.copyWith(color: colors.onSurface)),
                        ),
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
          Expanded(
            child: Text(k, style: AppTextStyles.s10Regular.copyWith(color: colors.onSurfaceDim)),
          ),
          Text(v, style: AppTextStyles.s12SemiBold.copyWith(color: colors.onSurface)),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final colors = context.colors;
    final actions = const [
      (ImageResources.icPayments, 'Payments'),
      (ImageResources.icDocuments, 'Documents'),
      (ImageResources.icSupport, 'Support'),
      (ImageResources.icStatement, 'Statement'),
    ];
    return Row(
      children: List.generate(actions.length, (i) {
        final a = actions[i];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i == actions.length - 1 ? 0 : 8),
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
        );
      }),
    );
  }

  Widget _buildConstructionCard(ConstructionProgress construction) {
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
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
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
                    Expanded(
                      child: Text('Project Completion', style: AppTextStyles.s13Medium.copyWith(color: colors.onSurface)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                      decoration: BoxDecoration(color: colors.primaryTeal.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        '${(construction.progressPercent * 100).toInt()}%',
                        style: AppTextStyles.s11SemiBold.copyWith(color: colors.primaryTeal),
                      ),
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

  Widget _buildUnitSummary(UnitInfo unit) {
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
        Expanded(
          child: Text(label, style: AppTextStyles.s12Regular.copyWith(color: colors.onSurfaceDim)),
        ),
        Text(value, style: AppTextStyles.s12SemiBold.copyWith(color: colors.onSurface)),
      ],
    );
  }

  Widget _buildRecentActivity(List<ActivityItem> activities) {
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

  Widget _activityItem(ActivityItem item) {
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
              Text(
                item.subtitle,
                style: AppTextStyles.s11Regular.copyWith(color: colors.onSurfaceDim),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(item.timeLabel, style: AppTextStyles.s10Regular.copyWith(color: colors.onSurfaceDim)),
      ],
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.surfaceContainerHigh,
        border: Border.all(color: colors.primaryTeal.withValues(alpha: 0.35)),
      ),
      child: Icon(Icons.person_rounded, size: 18, color: colors.primaryTealFixedDim),
    );
  }
}
