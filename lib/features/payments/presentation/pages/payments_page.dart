import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/features/payments/domain/entities/payment.dart';
import 'package:temp_architecture_app_setup/features/payments/presentation/blocs/payments_bloc/payment_bloc.dart';

// ── Helpers ────────────────────────────────────────────────────────────────

extension _PaymentStatusUI on PaymentStatus {
  String get label {
    switch (this) {
      case PaymentStatus.paid:
        return 'PAID';
      case PaymentStatus.pending:
        return 'PENDING';
      case PaymentStatus.overdue:
        return 'OVERDUE';
      case PaymentStatus.upcoming:
        return 'UPCOMING';
    }
  }

  Color get color {
    switch (this) {
      case PaymentStatus.paid:
        return ColorPalette.paidGreen;
      case PaymentStatus.pending:
        return ColorPalette.pendingTeal;
      case PaymentStatus.overdue:
        return ColorPalette.overdueRed;
      case PaymentStatus.upcoming:
        return ColorPalette.upcomingGrey;
    }
  }

}

// ── Page ───────────────────────────────────────────────────────────────────

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String? _expandedId;

  static const _filterLabels = ['All', 'Paid', 'Due', 'Overdue', 'Upcoming'];
  static const _filterValues = [
    null,
    PaymentStatus.paid,
    PaymentStatus.pending,
    PaymentStatus.overdue,
    PaymentStatus.upcoming,
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => getIt<PaymentBloc>()..add(const PaymentsLoadRequested()),
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorPalette.surface,
            appBar: _buildAppBar(),
            body: _buildBody(context, state),
          );
        },
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
                      width: 1)),
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
                    offset: const Offset(0, 4))
              ],
            ),
            child: const Icon(Icons.home_work_rounded,
                size: 18, color: ColorPalette.white),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Architectural Curator',
                  style: AppTextStyles.s13SemiBold
                      .copyWith(color: ColorPalette.onSurface)),
              Text('UNIT 402 · SKY-VILLA',
                  style: AppTextStyles.s10Regular.copyWith(
                      color: ColorPalette.onSurfaceDim, letterSpacing: 1.2)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.swap_horiz_rounded,
              color: ColorPalette.onSurfaceVariant, size: 20),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, PaymentState state) {
    if (state.status == DataStatus.loading) {
      return const Center(
          child: CircularProgressIndicator(
              color: ColorPalette.primaryTeal, strokeWidth: 2));
    }
    if (state.status == DataStatus.error) {
      return Center(
          child: Text(state.error ?? 'Something went wrong',
              style: AppTextStyles.s13Regular
                  .copyWith(color: ColorPalette.onSurfaceVariant)));
    }
    if (state.data == null) return const SizedBox.shrink();

    final data = state.data!;
    final items = state.filteredItems;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              _buildSummary(data.summary),
              const SizedBox(height: 20),
              _buildFilters(context, state.activeFilter),
              const SizedBox(height: 16),
              ...items.map((item) => _buildPaymentCard(item)),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildSummary(PaymentSummary summary) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ColorPalette.surfaceContainer, ColorPalette.surfaceContainerLow],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: ColorPalette.outlineVariant.withValues(alpha: 0.15), width: 1),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            bottom: -8,
            child: SvgPicture.asset(
              ImageResources.icTotalOutstanding,
              width: 80,
              height: 80,
              colorFilter: ColorFilter.mode(
                  ColorPalette.primaryTeal.withValues(alpha: 0.06),
                  BlendMode.srcIn),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Outstanding',
                  style: AppTextStyles.s12Regular
                      .copyWith(color: ColorPalette.onSurfaceVariant)),
              const SizedBox(height: 6),
              Text(summary.totalOutstanding,
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
                                color: ColorPalette.onSurfaceDim,
                                letterSpacing: 1)),
                        const SizedBox(height: 2),
                        Text(summary.paid,
                            style: AppTextStyles.s13SemiBold
                                .copyWith(color: ColorPalette.primaryTeal)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NEXT DUE',
                            style: AppTextStyles.s10Regular.copyWith(
                                color: ColorPalette.onSurfaceDim,
                                letterSpacing: 1)),
                        const SizedBox(height: 2),
                        Text(summary.nextDue,
                            style: AppTextStyles.s13SemiBold
                                .copyWith(color: ColorPalette.warningAmber)),
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

  Widget _buildFilters(BuildContext context, PaymentStatus? activeFilter) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filterLabels.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final selected = _filterValues[i] == activeFilter;
          return GestureDetector(
            onTap: () => context
                .read<PaymentBloc>()
                .add(PaymentsFilterChanged(_filterValues[i])),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: selected
                    ? ColorPalette.primaryTealContainer
                    : ColorPalette.surfaceContainer,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(
                    color: selected
                        ? Colors.transparent
                        : ColorPalette.outlineVariant,
                    width: 1),
              ),
              child: Text(
                _filterLabels[i],
                style: AppTextStyles.s12Medium.copyWith(
                  color: selected
                      ? ColorPalette.onPrimaryTealContainer
                      : ColorPalette.onSurfaceVariant,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaymentCard(PaymentItem item) {
    final statusColor = item.status.color;
    final isExpanded = _expandedId == item.id;
    final hasBreakdown = item.breakdown.isNotEmpty;

    return Column(
      children: [
        GestureDetector(
          onTap: hasBreakdown
              ? () => setState(
                  () => _expandedId = isExpanded ? null : item.id)
              : null,
          child: Container(
            margin: const EdgeInsets.only(bottom: 0),
            decoration: BoxDecoration(
              color: ColorPalette.surfaceContainer,
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(12),
                bottom: Radius.circular(isExpanded ? 0 : 12),
              ),
              border: Border.all(
                  color: ColorPalette.outlineVariant.withValues(alpha: 0.15),
                  width: 1),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 6,
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.horizontal(
                          left: const Radius.circular(12)),
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
                                child: Text(item.stage,
                                    style: AppTextStyles.s14SemiBold
                                        .copyWith(color: ColorPalette.onSurface)),
                              ),
                              _Badge(
                                  label: item.status.label, color: statusColor),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(item.subtitle,
                              style: AppTextStyles.s11Regular
                                  .copyWith(color: ColorPalette.onSurfaceDim)),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.amountLabel,
                                      style: AppTextStyles.s10Regular.copyWith(
                                          color: ColorPalette.onSurfaceDim,
                                          letterSpacing: 0.5)),
                                  const SizedBox(height: 2),
                                  Text(item.amount,
                                      style: AppTextStyles.s16SemiBold.copyWith(
                                          color: ColorPalette.onSurface,
                                          letterSpacing: -0.3)),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(item.dateLabel,
                                      style: AppTextStyles.s11SemiBold
                                          .copyWith(color: statusColor)),
                                  if (item.actionLabel.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(item.actionLabel,
                                            style: AppTextStyles.s12Medium
                                                .copyWith(
                                                    color: ColorPalette
                                                        .primaryTeal)),
                                        const SizedBox(width: 2),
                                        Icon(
                                          hasBreakdown
                                              ? Icons.keyboard_arrow_down_rounded
                                              : Icons.open_in_new_rounded,
                                          size: 12,
                                          color: ColorPalette.primaryTeal,
                                        ),
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
        ),
        if (isExpanded && item.breakdown.isNotEmpty)
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            decoration: BoxDecoration(
              color: ColorPalette.surfaceContainerHigh,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(12)),
              border: Border.all(
                  color: ColorPalette.outlineVariant.withValues(alpha: 0.15),
                  width: 1),
            ),
            child: Column(
              children: [
                ...item.breakdown.map((b) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: _BreakdownItem(b.label, b.value),
                    )),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      color: ColorPalette.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded,
                          size: 12, color: ColorPalette.onSurfaceDim),
                      const SizedBox(width: 6),
                      Text('Payment via RTGS/NEFT only.',
                          style: AppTextStyles.s11Regular
                              .copyWith(color: ColorPalette.onSurfaceDim)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 12),
      ],
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
          borderRadius: BorderRadius.circular(99)),
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
          borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: AppTextStyles.s12Regular
                  .copyWith(color: ColorPalette.onSurfaceVariant)),
          Text(value,
              style:
                  AppTextStyles.s12Medium.copyWith(color: ColorPalette.onSurface)),
        ],
      ),
    );
  }
}
