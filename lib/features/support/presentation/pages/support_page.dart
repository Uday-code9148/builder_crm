import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _filterIndex = 0;
  static const _filters = ['All', 'Open', 'In Progress', 'Resolved'];

  static const _tickets = [
    _Ticket(
      id: 'TCK-4921',
      category: 'MAINTENANCE',
      categoryColor: ColorPalette.pendingTeal,
      title: 'HVAC Performance at Skyglass Penthouse',
      preview: 'Unit 402 reporting intermittent…',
      statusLabel: 'In Progress',
      statusColor: ColorPalette.warningAmber,
      timeLabel: 'Resolution due in 18 hours',
      timeLabelColor: ColorPalette.warningAmber,
      timeLabelIcon: Icons.schedule_rounded,
    ),
    _Ticket(
      id: 'TCK-5012',
      category: 'LEGAL',
      categoryColor: ColorPalette.secondaryPurple,
      title: 'Zoning Document Verification Request',
      preview: 'Client needs signed architectural…',
      statusLabel: 'Open',
      statusColor: ColorPalette.primaryTeal,
      timeLabel: 'Due in 3 days',
      timeLabelColor: ColorPalette.onSurfaceDim,
      timeLabelIcon: Icons.calendar_today_rounded,
    ),
    _Ticket(
      id: 'TCK-3882',
      category: 'BILLING',
      categoryColor: ColorPalette.paidGreen,
      title: 'Curation Fee Dispute – Q3',
      preview: 'Invoice reconciliation for the monthl…',
      statusLabel: 'Resolved',
      statusColor: ColorPalette.paidGreen,
      timeLabel: 'Closed Oct 24',
      timeLabelColor: ColorPalette.onSurfaceDim,
      timeLabelIcon: Icons.check_circle_outline_rounded,
    ),
    _Ticket(
      id: 'TCK-4819',
      category: 'SECURITY',
      categoryColor: ColorPalette.overdueRed,
      title: 'Biometric Gate Access Failure',
      preview: 'Main gate scanner not recognizing…',
      statusLabel: 'In Progress',
      statusColor: ColorPalette.warningAmber,
      timeLabel: 'Resolution due in 4 hours',
      timeLabelColor: ColorPalette.overdueRed,
      timeLabelIcon: Icons.schedule_rounded,
    ),
  ];

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
                const SizedBox(height: 24),
                _buildHeader(),
                const SizedBox(height: 16),
                _buildNewTicketButton(),
                const SizedBox(height: 20),
                _buildFilters(),
                const SizedBox(height: 16),
                ..._tickets.map((t) => _TicketCard(ticket: t)),
                const SizedBox(height: 8),
                _buildLoadMore(),
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

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Support Tickets',
            style: AppTextStyles.s24Bold.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: ColorPalette.onSurface,
                letterSpacing: -0.5)),
        const SizedBox(height: 6),
        Text('Manage architectural inquiries and property maintenance requests.',
            style: AppTextStyles.s13Regular.copyWith(
                color: ColorPalette.onSurfaceVariant, height: 1.4)),
      ],
    );
  }

  Widget _buildNewTicketButton() {
    return GestureDetector(
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColorPalette.primaryTeal, ColorPalette.primaryTealContainer],
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ColorPalette.primaryTeal.withValues(alpha: 0.25),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageResources.icAddTicket,
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(ColorPalette.onPrimaryTeal, BlendMode.srcIn),
            ),
            const SizedBox(width: 8),
            Text('New Ticket',
                style: AppTextStyles.s14SemiBold.copyWith(color: ColorPalette.onPrimaryTeal)),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 34,
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selected ? ColorPalette.primaryTeal : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  _filters[i],
                  style: AppTextStyles.s13Medium.copyWith(
                    color: selected ? ColorPalette.primaryTeal : ColorPalette.onSurfaceDim,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadMore() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          color: ColorPalette.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(99),
          border: Border.all(
            color: ColorPalette.outlineVariant.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        child: Text('Load More Tickets',
            style: AppTextStyles.s13Medium.copyWith(color: ColorPalette.primaryTeal)),
      ),
    );
  }
}

class _Ticket {
  final String id;
  final String category;
  final Color categoryColor;
  final String title;
  final String preview;
  final String statusLabel;
  final Color statusColor;
  final String timeLabel;
  final Color timeLabelColor;
  final IconData timeLabelIcon;

  const _Ticket({
    required this.id,
    required this.category,
    required this.categoryColor,
    required this.title,
    required this.preview,
    required this.statusLabel,
    required this.statusColor,
    required this.timeLabel,
    required this.timeLabelColor,
    required this.timeLabelIcon,
  });
}

class _TicketCard extends StatelessWidget {
  final _Ticket ticket;
  const _TicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: ColorPalette.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorPalette.outlineVariant.withValues(alpha: 0.15), width: 1),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Left accent bar
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: ticket.statusColor,
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: ticket ID + category
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: ColorPalette.primaryTeal.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(ticket.id,
                              style: AppTextStyles.s11Regular.copyWith(
                                  color: ColorPalette.primaryTeal,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3)),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 28,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: ticket.categoryColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: ticket.categoryColor.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: ticket.categoryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(ticket.category,
                                  style: AppTextStyles.s9SemiBold.copyWith(
                                      color: ticket.categoryColor, letterSpacing: 0.5)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(ticket.title,
                        style: AppTextStyles.s15SemiBold.copyWith(
                            color: ColorPalette.onSurface, letterSpacing: -0.2)),
                    const SizedBox(height: 3),
                    Text(ticket.preview,
                        style: AppTextStyles.s12Regular.copyWith(
                            color: ColorPalette.onSurfaceVariant)),
                    const SizedBox(height: 12),
                    // Bottom row: status + time
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: ticket.statusColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(99),
                            border: Border.all(
                                color: ticket.statusColor.withValues(alpha: 0.3), width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: ticket.statusColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(ticket.statusLabel,
                                  style: AppTextStyles.s10SemiBold
                                      .copyWith(color: ticket.statusColor)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Icon(ticket.timeLabelIcon, size: 11, color: ticket.timeLabelColor),
                        const SizedBox(width: 4),
                        Text(ticket.timeLabel,
                            style: AppTextStyles.s11Regular
                                .copyWith(color: ticket.timeLabelColor)),
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
