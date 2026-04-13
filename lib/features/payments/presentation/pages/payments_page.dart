import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _filterIndex = 0;
  static const _filters = ['All', 'Paid', 'Due', 'Overdue', 'Upcoming'];

  bool _expanded = false; // brickwork card expanded state

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                _buildSummary(),
                const SizedBox(height: 20),
                _buildFilters(),
                const SizedBox(height: 16),
                _buildOverdueCard(),
                const SizedBox(height: 12),
                _buildBrickworkCard(),
                const SizedBox(height: 12),
                _buildFoundationCard(),
                const SizedBox(height: 12),
                _buildFinishingCard(),
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
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Architectural Curator',
                  style: AppTextStyles.s13SemiBold.copyWith(color: ColorPalette.onSurface)),
              Text('UNIT 402 · SKY-VILLA',
                  style: AppTextStyles.s10Regular.copyWith(
                      color: ColorPalette.onSurfaceDim, letterSpacing: 1.2)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.swap_horiz_rounded, color: ColorPalette.onSurfaceVariant, size: 20),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ColorPalette.surfaceContainer, ColorPalette.surfaceContainerLow],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorPalette.outlineVariant.withValues(alpha: 0.15), width: 1),
      ),
      child: Stack(
        children: [
          // Watermark icon
          Positioned(
            right: -8,
            bottom: -8,
            child: SvgPicture.asset(
              ImageResources.icTotalOutstanding,
              width: 80,
              height: 80,
              colorFilter: ColorFilter.mode(
                ColorPalette.primaryTeal.withValues(alpha: 0.06),
                BlendMode.srcIn,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Outstanding',
                  style: AppTextStyles.s12Regular.copyWith(color: ColorPalette.onSurfaceVariant)),
              const SizedBox(height: 6),
              Text('₹45,50,000',
                  style: AppTextStyles.s24Bold.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: ColorPalette.onSurface,
                      letterSpacing: -0.5)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PAID',
                            style: AppTextStyles.s10Regular.copyWith(
                                color: ColorPalette.onSurfaceDim, letterSpacing: 1)),
                        const SizedBox(height: 2),
                        Text('₹1,25,00,000',
                            style: AppTextStyles.s13SemiBold.copyWith(color: ColorPalette.primaryTeal)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NEXT DUE',
                            style: AppTextStyles.s10Regular.copyWith(
                                color: ColorPalette.onSurfaceDim, letterSpacing: 1)),
                        const SizedBox(height: 2),
                        Text('₹15,00,000',
                            style: AppTextStyles.s13SemiBold.copyWith(color: ColorPalette.warningAmber)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final selected = i == _filterIndex;
          return GestureDetector(
            onTap: () => setState(() => _filterIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? ColorPalette.primaryTealContainer : ColorPalette.surfaceContainer,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(
                  color: selected ? Colors.transparent : ColorPalette.outlineVariant,
                  width: 1,
                ),
              ),
              child: Text(
                _filters[i],
                style: AppTextStyles.s12Medium.copyWith(
                  color: selected ? ColorPalette.onPrimaryTealContainer : ColorPalette.onSurfaceVariant,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverdueCard() {
    return _PaymentCard(
      stage: 'Slab 08 Completion',
      subtitle: '8th Floor Structural Work',
      badge: 'OVERDUE',
      badgeColor: ColorPalette.overdueRed,
      label: 'AMOUNT DUE',
      amount: '₹15,00,000',
      dateLabel: 'DUE 12 OCT 2023',
      dateColor: ColorPalette.overdueRed,
      actionLabel: 'View Details',
      actionIcon: Icons.keyboard_arrow_down_rounded,
      leftAccentColor: ColorPalette.overdueRed,
    );
  }

  Widget _buildBrickworkCard() {
    return Column(
      children: [
        _PaymentCard(
          stage: 'Brickwork Level 04',
          subtitle: 'Internal & External Masonry',
          badge: 'PENDING',
          badgeColor: ColorPalette.pendingTeal,
          label: 'AMOUNT DUE',
          amount: '₹12,50,000',
          dateLabel: 'DUE 28 NOV 2023',
          dateColor: ColorPalette.pendingTeal,
          actionLabel: 'Pay Now',
          actionIcon: Icons.open_in_new_rounded,
          leftAccentColor: ColorPalette.pendingTeal,
          onTap: () => setState(() => _expanded = !_expanded),
        ),
        if (_expanded)
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            decoration: BoxDecoration(
              color: ColorPalette.surfaceContainerHigh,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              border: Border.all(color: ColorPalette.outlineVariant.withValues(alpha: 0.15), width: 1),
            ),
            child: Column(
              children: [
                _BreakdownItem('Principal Amount', '₹11,16,071'),
                const SizedBox(height: 6),
                _BreakdownItem('GST (12%)', '₹1,33,929'),
                const SizedBox(height: 6),
                _BreakdownItem('TDS (1%)', '- ₹11,160'),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorPalette.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, size: 12, color: ColorPalette.onSurfaceDim),
                      const SizedBox(width: 6),
                      Text('Payment via RTGS/NEFT only.',
                          style: AppTextStyles.s11Regular.copyWith(color: ColorPalette.onSurfaceDim)),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildFoundationCard() {
    return _PaymentCard(
      stage: 'Foundation Completion',
      subtitle: 'Raft & Piling Work Finished',
      badge: 'PAID',
      badgeColor: ColorPalette.paidGreen,
      label: 'AMOUNT PAID',
      amount: '₹18,00,000',
      dateLabel: '15 SEP 2023',
      dateColor: ColorPalette.onSurfaceVariant,
      actionLabel: 'Receipt',
      actionIcon: Icons.download_rounded,
      leftAccentColor: ColorPalette.paidGreen,
    );
  }

  Widget _buildFinishingCard() {
    return _PaymentCard(
      stage: 'Finishing & Plaster',
      subtitle: 'Stage 12 of 15',
      badge: 'UPCOMING',
      badgeColor: ColorPalette.upcomingGrey,
      label: 'EST. AMOUNT',
      amount: '₹8,00,000',
      dateLabel: 'JAN 2024',
      dateColor: ColorPalette.onSurfaceDim,
      actionLabel: '',
      actionIcon: null,
      leftAccentColor: ColorPalette.upcomingGrey,
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final String stage;
  final String subtitle;
  final String badge;
  final Color badgeColor;
  final String label;
  final String amount;
  final String dateLabel;
  final Color dateColor;
  final String actionLabel;
  final IconData? actionIcon;
  final Color leftAccentColor;
  final VoidCallback? onTap;

  const _PaymentCard({
    required this.stage,
    required this.subtitle,
    required this.badge,
    required this.badgeColor,
    required this.label,
    required this.amount,
    required this.dateLabel,
    required this.dateColor,
    required this.actionLabel,
    required this.actionIcon,
    required this.leftAccentColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalette.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorPalette.outlineVariant.withValues(alpha: 0.15), width: 1),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Left accent
              Container(
                width: 6,
                decoration: BoxDecoration(
                  color: leftAccentColor,
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(stage,
                                style: AppTextStyles.s14SemiBold.copyWith(color: ColorPalette.onSurface)),
                          ),
                          _Badge(label: badge, color: badgeColor),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(subtitle,
                          style: AppTextStyles.s11Regular.copyWith(color: ColorPalette.onSurfaceDim)),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(label,
                                  style: AppTextStyles.s10Regular.copyWith(
                                      color: ColorPalette.onSurfaceDim, letterSpacing: 0.5)),
                              const SizedBox(height: 2),
                              Text(amount,
                                  style: AppTextStyles.s16SemiBold.copyWith(
                                      color: ColorPalette.onSurface, letterSpacing: -0.3)),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(dateLabel,
                                  style: AppTextStyles.s11SemiBold.copyWith(color: dateColor)),
                              if (actionLabel.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(actionLabel,
                                        style: AppTextStyles.s12Medium.copyWith(
                                            color: ColorPalette.primaryTeal)),
                                    if (actionIcon != null) ...[
                                      const SizedBox(width: 2),
                                      Icon(actionIcon, size: 12, color: ColorPalette.primaryTeal),
                                    ],
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(label,
          style: AppTextStyles.s9SemiBold.copyWith(color: color, letterSpacing: 0.5)),
    );
  }
}

class _BreakdownItem extends StatelessWidget {
  final String label;
  final String value;
  const _BreakdownItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ColorPalette.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.s12Regular.copyWith(color: ColorPalette.onSurfaceVariant)),
          Text(value, style: AppTextStyles.s12Medium.copyWith(color: ColorPalette.onSurface)),
        ],
      ),
    );
  }
}
