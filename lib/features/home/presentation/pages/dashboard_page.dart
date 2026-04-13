import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/features/home/presentation/widgets/more_menu_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late final AnimationController _progressCtrl;
  late final Animation<double> _progressAnim;
  final _scrollCtrl = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _progressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
    _progressAnim = CurvedAnimation(
      parent: _progressCtrl,
      curve: const Cubic(0.2, 0.8, 0.2, 1),
    );
    _scrollCtrl.addListener(() => setState(() => _scrollOffset = _scrollCtrl.offset));
  }

  @override
  void dispose() {
    _progressCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: ColorPalette.surface,
      body: CustomScrollView(
        controller: _scrollCtrl,
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildGlassAppBar(),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 24),
                _buildGreeting(),
                const SizedBox(height: 16),
                _buildAlertCard(),
                const SizedBox(height: 16),
                _buildPaymentSnapshot(),
                const SizedBox(height: 16),
                _buildQuickActions(),
                const SizedBox(height: 16),
                _buildConstructionCard(),
                const SizedBox(height: 16),
                _buildUnitSummary(),
                const SizedBox(height: 16),
                _buildRecentActivity(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassAppBar() {
    final scrolled = _scrollOffset > 8;
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
          filter: ImageFilter.blur(
            sigmaX: scrolled ? 16 : 0,
            sigmaY: scrolled ? 16 : 0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: ColorPalette.surface.withValues(alpha: scrolled ? 0.92 : 1.0),
              border: scrolled
                  ? Border(
                      bottom: BorderSide(
                        color: ColorPalette.outlineVariant.withValues(alpha: 0.3),
                      ),
                    )
                  : null,
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const MoreMenuWidget(),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Architectural Curator',
                            style: AppTextStyles.s13SemiBold.copyWith(color: ColorPalette.onSurface)),
                        Text('UNIT 402 · SKY-VILLA',
                            style: AppTextStyles.s9Regular.copyWith(
                              color: ColorPalette.onSurfaceDim,
                              letterSpacing: 1.2,
                            )),
                      ],
                    ),
                    const Spacer(),
                    _IconBtn(icon: Icons.swap_horiz_rounded, onTap: () {}),
                    const SizedBox(width: 8),
                    const _AvatarWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Good Morning, Rajesh',
            style: AppTextStyles.s22SemiBold.copyWith(color: ColorPalette.onSurface)),
        const SizedBox(height: 4),
        Text('Welcome back to your portfolio overview.',
            style: AppTextStyles.s13Regular.copyWith(color: ColorPalette.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildAlertCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorPalette.warningContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorPalette.warningAmber.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: ColorPalette.warningAmber),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Action Required: Pending payment of ₹15,00,000.',
              style: AppTextStyles.s12Medium.copyWith(color: ColorPalette.onWarningContainer),
            ),
          ),
          Text('Pay Now', style: AppTextStyles.s12SemiBold.copyWith(color: ColorPalette.primaryTeal)),
        ],
      ),
    );
  }

  Widget _buildPaymentSnapshot() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorPalette.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorPalette.outlineVariant.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Snapshot', style: AppTextStyles.s14SemiBold.copyWith(color: ColorPalette.onSurface)),
          const SizedBox(height: 14),
          Row(
            children: [
              SizedBox(
                width: 88,
                height: 88,
                child: AnimatedBuilder(
                  animation: _progressAnim,
                  builder: (_, _) {
                    final value = 0.65 * _progressAnim.value;
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: 1,
                          strokeWidth: 8,
                          valueColor: const AlwaysStoppedAnimation(ColorPalette.surfaceContainerHigh),
                        ),
                        CircularProgressIndicator(
                          value: value,
                          strokeWidth: 8,
                          valueColor: const AlwaysStoppedAnimation(ColorPalette.primaryTeal),
                        ),
                        Center(
                          child: Text(
                            '${(65 * _progressAnim.value).toInt()}%',
                            style: AppTextStyles.s16SemiBold.copyWith(color: ColorPalette.onSurface),
                          ),
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
                  children: [
                    _row('TOTAL PAID', '₹84,50,000'),
                    _row('NEXT DUE', '₹42,20,000'),
                    _row('BALANCE', '₹42,30,000'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(String k, String v) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            Expanded(child: Text(k, style: AppTextStyles.s10Regular.copyWith(color: ColorPalette.onSurfaceDim))),
            Text(v, style: AppTextStyles.s12SemiBold.copyWith(color: ColorPalette.onSurface)),
          ],
        ),
      );

  Widget _buildQuickActions() {
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
                color: ColorPalette.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorPalette.outlineVariant.withValues(alpha: 0.15)),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(a.$1, width: 20, height: 20),
                  const SizedBox(height: 8),
                  Text(a.$2, style: AppTextStyles.s10Medium.copyWith(color: ColorPalette.onSurfaceVariant)),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildConstructionCard() {
    return _sectionCard('Construction Milestone', 'Project completion 49%');
  }

  Widget _buildUnitSummary() {
    return _sectionCard('Unit Summary', '3 BHK Luxury • 1,840 sq.ft.');
  }

  Widget _buildRecentActivity() {
    return _sectionCard('Recent Activity', 'Maintenance payment confirmed • 36 min ago');
  }

  Widget _sectionCard(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorPalette.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorPalette.outlineVariant.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.s14SemiBold.copyWith(color: ColorPalette.onSurface)),
          const SizedBox(height: 4),
          Text(subtitle, style: AppTextStyles.s12Regular.copyWith(color: ColorPalette.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorPalette.surfaceContainerHigh,
        border: Border.all(color: ColorPalette.primaryTeal.withValues(alpha: 0.35)),
      ),
      child: const Icon(Icons.person_rounded, size: 18, color: ColorPalette.primaryTealFixedDim),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: ColorPalette.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(icon, size: 18, color: ColorPalette.onSurfaceVariant),
      ),
    );
  }
}
