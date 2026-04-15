import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateful_widget.dart';
import 'package:temp_architecture_app_setup/core/common/constants/app_display_constants.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/curator_glass_app_bar.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/enums/data_status.dart';
import 'package:temp_architecture_app_setup/core/enums/payment_status.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/features/payments/domain/entities/payment_entities.dart';
import 'package:temp_architecture_app_setup/features/payments/presentation/blocs/payments_bloc/payment_bloc.dart';
import 'package:temp_architecture_app_setup/features/payments/presentation/helpers/payment_breakdown_resolver.dart';
import 'package:temp_architecture_app_setup/features/payments/presentation/widgets/payments_loading_skeleton.dart';

// ── Page ───────────────────────────────────────────────────────────────────

class PaymentsPage extends BaseStatefulWidget {
  final String headerTitle;
  final String? headerSubtitle;

  const PaymentsPage({super.key, this.headerTitle = AppDisplayConstants.appTitle, this.headerSubtitle = AppDisplayConstants.unitLabel});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends BaseState<PaymentsPage> with AutomaticKeepAliveClientMixin {
  String? _expandedId;

  @override
  bool get wantKeepAlive => true;

  static const _filterLabels = ['All', 'Paid', 'Due', 'Overdue', 'Upcoming'];
  static const _filterValues = [null, PaymentStatus.paid, PaymentStatus.pending, PaymentStatus.overdue, PaymentStatus.upcoming];

  @override
  Widget build(BuildContext context) {
    super.build(context); // required by AutomaticKeepAliveClientMixin
    return buildContent(context);
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PaymentBloc>()..add(const PaymentsLoadRequested()),
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          return Scaffold(backgroundColor: context.colors.surface, appBar: _buildAppBar(), body: _buildBody(context, state));
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return buildCuratorGlassAppBar(context: context, title: widget.headerTitle, subtitle: widget.headerSubtitle);
  }

  Widget _buildBody(BuildContext context, PaymentState state) {
    final colors = context.colors;
    if (state.status == DataStatus.loading) {
      return const PaymentsLoadingSkeleton();
    }
    if (state.status == DataStatus.error) {
      return Center(
        child: Text(state.error ?? 'Something went wrong', style: AppTextStyles.s13Regular.copyWith(color: colors.onSurfaceVariant)),
      );
    }
    if (state.data == null) return const SizedBox.shrink();

    final data = state.data!;
    final items = state.filteredItems;
    final summary = data.summary ?? const PaymentSummaryEntity();

    return RefreshIndicator(
      color: colors.primaryTeal,
      notificationPredicate: (n) => n.depth == 0,
      onRefresh: () async {
        final bloc = context.read<PaymentBloc>();
        bloc.add(const PaymentsLoadRequested());
        try {
          await bloc.stream.firstWhere((s) => s.status != DataStatus.loading).timeout(const Duration(seconds: 12));
        } catch (_) {
          // End the indicator even if the request fails/timeout.
        }
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 20),
                _buildSummary(summary),
                const SizedBox(height: 20),
                _buildFilters(context, state.activeFilter),
                const SizedBox(height: 16),
                ...items.map((item) => _buildPaymentCard(item)),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(PaymentSummaryEntity summary) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [colors.surfaceContainer, colors.surfaceContainerLow]),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15), width: 1),
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
              colorFilter: ColorFilter.mode(colors.primaryTeal.withValues(alpha: 0.06), BlendMode.srcIn),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Outstanding', style: AppTextStyles.s12Regular.copyWith(color: colors.onSurfaceVariant)),
              const SizedBox(height: 6),
              Text(
                summary.totalOutstanding ?? '--',
                style: AppTextStyles.s24Bold.copyWith(fontSize: 32, fontWeight: FontWeight.w900, color: colors.onSurface, letterSpacing: -0.5),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PAID', style: AppTextStyles.s10Regular.copyWith(color: colors.onSurfaceDim, letterSpacing: 1)),
                        const SizedBox(height: 2),
                        Text(summary.paid ?? '--', style: AppTextStyles.s13SemiBold.copyWith(color: colors.primaryTeal)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NEXT DUE', style: AppTextStyles.s10Regular.copyWith(color: colors.onSurfaceDim, letterSpacing: 1)),
                        const SizedBox(height: 2),
                        Text(summary.nextDue ?? '--', style: AppTextStyles.s13SemiBold.copyWith(color: colors.warningAmber)),
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
    final colors = context.colors;
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filterLabels.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final selected = _filterValues[i] == activeFilter;
          return GestureDetector(
            onTap: () => context.read<PaymentBloc>().add(PaymentsFilterChanged(_filterValues[i])),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              decoration: BoxDecoration(
                color: selected ? colors.primaryTealContainer : colors.surfaceContainer,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: selected ? ColorPalette.transparent : colors.outlineVariant, width: 1),
              ),
              child: Text(
                _filterLabels[i],
                style: AppTextStyles.s12Medium.copyWith(color: selected ? colors.onPrimaryTealContainer : colors.onSurfaceVariant),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaymentCard(PaymentItemEntity item) {
    final colors = context.colors;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final status = item.status ?? PaymentStatus.upcoming;
    final statusColor = status.color;
    final isExpanded = _expandedId == item.id;
    final actionLabel = item.actionLabel ?? '';
    final canOpenDetails = actionLabel.isNotEmpty || (item.breakdown?.isNotEmpty ?? false);
    final detailRows = PaymentBreakdownResolver.resolve(item);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: const Radius.circular(12), bottom: Radius.circular(isExpanded ? 0 : 12)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: const Radius.circular(12), bottom: Radius.circular(isExpanded ? 0 : 12)),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDarkMode ? const [Color(0xFF131A1C), Color(0xFF15282A)] : [colors.surfaceContainer, colors.surfaceContainerLow],
                ),
                border: Border.all(color: statusColor.withValues(alpha: 0.22), width: 1),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      decoration: BoxDecoration(
                        color: statusColor,
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
                                  child: Text(item.stage ?? '--', style: AppTextStyles.s14SemiBold.copyWith(color: colors.onSurface)),
                                ),
                                _Badge(label: status.label, color: statusColor),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(item.subtitle ?? '--', style: AppTextStyles.s11Regular.copyWith(color: colors.onSurfaceVariant)),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (item.amountLabel ?? '--').toUpperCase(),
                                      style: AppTextStyles.s10Regular.copyWith(color: colors.onSurfaceDim, letterSpacing: 0.9),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(item.amount ?? '--', style: AppTextStyles.s16SemiBold.copyWith(color: colors.onSurface, letterSpacing: -0.3)),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text((item.dateLabel ?? '--').toUpperCase(), style: AppTextStyles.s11SemiBold.copyWith(color: colors.onSurfaceVariant)),
                                    if (actionLabel.isNotEmpty) ...[
                                      const SizedBox(height: 4),
                                      GestureDetector(
                                        onTap: canOpenDetails
                                            ? () => setState(() {
                                                _expandedId = isExpanded ? null : item.id;
                                              })
                                            : null,
                                        behavior: HitTestBehavior.opaque,
                                        child: Row(
                                          children: [
                                            Text(actionLabel, style: AppTextStyles.s12Medium.copyWith(color: ColorPalette.primaryTealFixed)),
                                            const SizedBox(width: 2),
                                            Icon(
                                              isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                                              size: 14,
                                              color: ColorPalette.primaryTealFixed,
                                            ),
                                          ],
                                        ),
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
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: isExpanded
              ? Container(
                  key: ValueKey('expanded_${item.id ?? ''}'),
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF1B2426) : colors.surfaceContainerLow,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                    border: Border.all(color: statusColor.withValues(alpha: 0.2), width: 1),
                  ),
                  child: Column(
                    children: [
                      ...detailRows.map(
                        (b) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _ExpandedDetailRow(label: b.label ?? '--', value: b.value ?? '--'),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: isDarkMode ? colors.white.withValues(alpha: 0.1) : colors.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('Payment via RTGS/NEFT only.', style: AppTextStyles.s11Regular.copyWith(color: colors.primaryTeal)),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
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
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(99)),
      child: Text(label, style: AppTextStyles.s9SemiBold.copyWith(color: color, letterSpacing: 0.5)),
    );
  }
}

class _ExpandedDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _ExpandedDetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      children: [
        Expanded(
          child: Text(label, style: AppTextStyles.s13Regular.copyWith(color: colors.onSurfaceVariant)),
        ),
        Text(value, style: AppTextStyles.s13SemiBold.copyWith(color: colors.onSurface)),
      ],
    );
  }
}
