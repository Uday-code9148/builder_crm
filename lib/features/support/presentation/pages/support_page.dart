import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateful_widget.dart';
import 'package:temp_architecture_app_setup/core/common/constants/app_display_constants.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/curator_glass_app_bar.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/enums/data_status.dart';
import 'package:temp_architecture_app_setup/core/enums/ticket_category.dart';
import 'package:temp_architecture_app_setup/core/enums/ticket_status.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/features/support/domain/entity/support_ticket_entity.dart';
import 'package:temp_architecture_app_setup/features/support/presentation/blocs/support_bloc/support_bloc.dart';
import 'package:temp_architecture_app_setup/features/support/presentation/blocs/create_ticket_bloc/create_ticket_bloc.dart';
import 'package:temp_architecture_app_setup/features/support/presentation/pages/new_ticket_page.dart';
import 'package:temp_architecture_app_setup/features/support/presentation/widgets/support_loading_skeleton.dart';

// ── Page ─────────────────────────────────────────────────────────────────

class SupportPage extends BaseStatefulWidget {
  final String headerTitle;
  final String? headerSubtitle;

  const SupportPage({super.key, this.headerTitle = AppDisplayConstants.appTitle, this.headerSubtitle});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends BaseState<SupportPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  static const _filterLabels = ['All', 'Open', 'In Progress', 'Resolved'];
  static const _filterValues = [null, TicketStatus.open, TicketStatus.inProgress, TicketStatus.resolved];

  @override
  Widget build(BuildContext context) {
    super.build(context); // required by AutomaticKeepAliveClientMixin
    return buildContent(context);
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SupportBloc>()..add(const SupportLoadRequested()),
      child: BlocBuilder<SupportBloc, SupportState>(
        builder: (context, state) {
          return Scaffold(backgroundColor: context.colors.surface, appBar: _buildAppBar(), body: _buildBody(context, state));
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return buildCuratorGlassAppBar(context: context, title: widget.headerTitle, subtitle: widget.headerSubtitle);
  }

  Widget _buildBody(BuildContext context, SupportState state) {
    final colors = context.colors;
    if (state.status == DataStatus.loading) {
      return const SupportLoadingSkeleton();
    }
    if (state.status == DataStatus.error) {
      return Center(
        child: Text(state.error ?? 'Something went wrong', style: AppTextStyles.s13Regular.copyWith(color: colors.onSurfaceVariant)),
      );
    }

    final tickets = state.filteredTickets;

    return RefreshIndicator(
      color: colors.primaryTeal,
      notificationPredicate: (n) => n.depth == 0,
      onRefresh: () async {
        final bloc = context.read<SupportBloc>();
        bloc.add(const SupportLoadRequested());
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
                const SizedBox(height: 24),
                _buildHeader(),
                const SizedBox(height: 16),
                _buildNewTicketButton(),
                const SizedBox(height: 20),
                _buildFilters(context, state.activeFilter),
                const SizedBox(height: 16),
                ...tickets.map((t) => _TicketCard(ticket: t)),
                const SizedBox(height: 8),
                _buildLoadMore(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Support Tickets',
          style: AppTextStyles.s24Bold.copyWith(fontSize: 30, fontWeight: FontWeight.w900, color: colors.onSurface, letterSpacing: -0.5),
        ),
        const SizedBox(height: 6),
        Text(
          'Manage architectural inquiries and property maintenance requests.',
          style: AppTextStyles.s13Regular.copyWith(color: colors.onSurfaceVariant, height: 1.4),
        ),
      ],
    );
  }

  Widget _buildNewTicketButton() {
    final colors = context.colors;
    return GestureDetector(
      onTap: () async {
        final created = await Navigator.of(context).push<SupportTicketEntity>(
          MaterialPageRoute(
            builder: (_) => BlocProvider(create: (_) => CreateTicketBloc(), child: const NewTicketPage()),
          ),
        );
        if (!mounted) return;
        if (created != null) context.read<SupportBloc>().add(SupportTicketAdded(created));
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [colors.primaryTeal, colors.primaryTealContainer]),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: colors.primaryTeal.withValues(alpha: 0.25), blurRadius: 24, offset: const Offset(0, 8))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(ImageResources.icAddTicket, width: 18, height: 18, colorFilter: ColorFilter.mode(colors.onPrimaryTeal, BlendMode.srcIn)),
            const SizedBox(width: 8),
            Text('New Ticket', style: AppTextStyles.s14SemiBold.copyWith(color: colors.onPrimaryTeal)),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters(BuildContext context, TicketStatus? activeFilter) {
    final colors = context.colors;
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filterLabels.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final selected = _filterValues[i] == activeFilter;
          return GestureDetector(
            onTap: () => context.read<SupportBloc>().add(SupportFilterChanged(_filterValues[i])),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: selected ? colors.primaryTeal : ColorPalette.transparent, width: 2)),
              ),
              child: Center(
                child: Text(_filterLabels[i], style: AppTextStyles.s13Medium.copyWith(color: selected ? colors.primaryTeal : colors.onSurfaceDim)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadMore() {
    final colors = context.colors;
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(99),
          border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.4), width: 1),
        ),
        child: Text('Load More Tickets', style: AppTextStyles.s13Medium.copyWith(color: colors.primaryTeal)),
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  final SupportTicketEntity ticket;

  const _TicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final status = ticket.status ?? TicketStatus.open;
    final category = ticket.category ?? TicketCategory.legal;
    final statusColor = status.color;
    final categoryColor = category.color;
    final timeLabelColor = (ticket.isUrgent ?? false) ? ColorPalette.overdueRed : colors.onSurfaceDim;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15), width: 1),
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: colors.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            ticket.id ?? '--',
                            style: AppTextStyles.s11Regular.copyWith(color: colors.primaryTeal, fontWeight: FontWeight.w700, letterSpacing: 0.3),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 28,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: categoryColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: categoryColor.withValues(alpha: 0.2), width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(color: categoryColor, shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 5),
                              Text(category.label, style: AppTextStyles.s9SemiBold.copyWith(color: categoryColor, letterSpacing: 0.5)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(ticket.title ?? '--', style: AppTextStyles.s15SemiBold.copyWith(color: colors.onSurface, letterSpacing: -0.2)),
                    const SizedBox(height: 3),
                    Text(ticket.preview ?? '--', style: AppTextStyles.s12Regular.copyWith(color: colors.onSurfaceVariant)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(99),
                            border: Border.all(color: statusColor.withValues(alpha: 0.3), width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 5),
                              Text(status.label, style: AppTextStyles.s10SemiBold.copyWith(color: statusColor)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Icon(status.timeIcon, size: 11, color: timeLabelColor),
                        const SizedBox(width: 4),
                        Text(ticket.timeLabel ?? '--', style: AppTextStyles.s11Regular.copyWith(color: timeLabelColor)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
