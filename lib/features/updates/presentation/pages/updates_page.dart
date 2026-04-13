import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';

class UpdatesPage extends StatefulWidget {
  const UpdatesPage({super.key});

  @override
  State<UpdatesPage> createState() => _UpdatesPageState();
}

class _UpdatesPageState extends State<UpdatesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  static const _milestones = [
    _Milestone(title: 'Foundation', subtitle: 'Completed March 12, 2024', progress: 1.0, status: 'Done'),
    _Milestone(title: 'Structure', subtitle: 'Completed April 28, 2024', progress: 1.0, status: 'Done'),
    _Milestone(title: 'MEP', subtitle: 'Mechanical, Electrical, Plumbing', progress: 1.0, status: 'Done'),
    _Milestone(title: 'Plastering', subtitle: 'In Progress', progress: 0.65, status: 'InProgress'),
    _Milestone(title: 'Interior', subtitle: 'Scheduled for June 2024', progress: 0.0, status: 'Upcoming'),
    _Milestone(title: 'Handover', subtitle: 'Estimated August 2024', progress: 0.0, status: 'Upcoming'),
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
                _buildProgressHero(),
                const SizedBox(height: 24),
                _buildMilestoneList(),
                const SizedBox(height: 24),
                _buildLatestPhotos(),
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

  Widget _buildProgressHero() {
    return Column(
      children: [
        SizedBox(
          width: 196,
          height: 196,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: 0.65,
                strokeWidth: 10,
                backgroundColor: ColorPalette.surfaceContainerHigh,
                valueColor: const AlwaysStoppedAnimation<Color>(ColorPalette.primaryTeal),
                strokeCap: StrokeCap.round,
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('65%',
                        style: AppTextStyles.s24Bold.copyWith(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: ColorPalette.onSurface,
                            letterSpacing: -1)),
                    const SizedBox(height: 2),
                    Text('TOTAL PROGRESS',
                        style: AppTextStyles.s9Regular.copyWith(
                            color: ColorPalette.onSurfaceDim, letterSpacing: 1.2)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text('The Emerald Pavilion',
            style: AppTextStyles.s22SemiBold.copyWith(
                color: ColorPalette.onSurface, letterSpacing: -0.4)),
        const SizedBox(height: 4),
        Text('Unit 402 • Phase II Construction',
            style: AppTextStyles.s13Regular.copyWith(color: ColorPalette.onSurfaceVariant)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: ColorPalette.surfaceContainerLow,
            borderRadius: BorderRadius.circular(99),
            border: Border.all(color: ColorPalette.outlineVariant.withValues(alpha: 0.4), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.access_time_rounded, size: 11, color: ColorPalette.onSurfaceDim),
              const SizedBox(width: 4),
              Text('Updated 2h ago',
                  style: AppTextStyles.s11Regular.copyWith(color: ColorPalette.onSurfaceDim)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMilestoneList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Milestones',
            style: AppTextStyles.s22SemiBold.copyWith(
                color: ColorPalette.onSurface, letterSpacing: -0.3)),
        const SizedBox(height: 16),
        // Timeline with vertical connectors
        ...List.generate(_milestones.length, (i) {
          final isLast = i == _milestones.length - 1;
          return _TimelineTile(
            milestone: _milestones[i],
            isLast: isLast,
          );
        }),
      ],
    );
  }

  Widget _buildLatestPhotos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Latest Photos',
                style: AppTextStyles.s14SemiBold.copyWith(color: ColorPalette.onSurface)),
            const Spacer(),
            Text('See All',
                style: AppTextStyles.s12Medium.copyWith(color: ColorPalette.primaryTeal)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _PhotoCard(label: 'EXTERIOR WALL')),
            const SizedBox(width: 12),
            Expanded(child: _PhotoCard(label: 'LIVING AREA')),
          ],
        ),
      ],
    );
  }
}

class _Milestone {
  final String title;
  final String subtitle;
  final double progress;
  final String status; // 'Done' | 'InProgress' | 'Upcoming'
  const _Milestone({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.status,
  });
}

class _TimelineTile extends StatelessWidget {
  final _Milestone milestone;
  final bool isLast;
  const _TimelineTile({required this.milestone, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final isDone = milestone.status == 'Done';
    final isInProgress = milestone.status == 'InProgress';
    final isUpcoming = milestone.status == 'Upcoming';

    final nodeColor = isDone
        ? ColorPalette.primaryTeal
        : isInProgress
            ? ColorPalette.warningAmber
            : ColorPalette.outlineVariant;

    final progressPct = '${(milestone.progress * 100).toInt()}%';

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: node + vertical connector
          SizedBox(
            width: 32,
            child: Column(
              children: [
                // Node circle — 24x24 matching SVG spec
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isDone
                        ? ColorPalette.primaryTeal
                        : isInProgress
                            ? ColorPalette.surfaceContainerHighest
                            : ColorPalette.surfaceContainerLow,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: nodeColor,
                      width: isDone ? 0 : (isInProgress ? 2 : 1),
                    ),
                  ),
                  child: isDone
                      ? const Icon(Icons.check_rounded, size: 13, color: ColorPalette.onPrimaryTeal)
                      : isInProgress
                          ? Center(
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: nodeColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          : Center(
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: ColorPalette.outlineVariant.withValues(alpha: 0.5),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                ),
                // Vertical connector line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isDone
                            ? ColorPalette.primaryTeal.withValues(alpha: 0.35)
                            : ColorPalette.outlineVariant.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Right: card content
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUpcoming
                    ? ColorPalette.surfaceContainerLow
                    : ColorPalette.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDone
                      ? ColorPalette.primaryTeal.withValues(alpha: 0.2)
                      : ColorPalette.outlineVariant.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          milestone.title,
                          style: AppTextStyles.s13SemiBold.copyWith(
                            color: isUpcoming
                                ? ColorPalette.onSurfaceDim
                                : ColorPalette.onSurface,
                          ),
                        ),
                      ),
                      if (isInProgress)
                        _MiniPill(label: 'In Progress', color: ColorPalette.warningAmber)
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: ColorPalette.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            progressPct,
                            style: AppTextStyles.s11SemiBold.copyWith(
                              color: isDone
                                  ? ColorPalette.primaryTeal
                                  : ColorPalette.onSurfaceDim,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    milestone.subtitle,
                    style: AppTextStyles.s11Regular
                        .copyWith(color: ColorPalette.onSurfaceDim),
                  ),
                  if (isInProgress) ...[
                    const SizedBox(height: 10),
                    Stack(
                      children: [
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: ColorPalette.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: milestone.progress,
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  ColorPalette.primaryTeal,
                                  ColorPalette.primaryTealContainer,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'View Photos',
                        style: AppTextStyles.s12Medium.copyWith(
                          color: isUpcoming
                              ? ColorPalette.onSurfaceDim
                              : ColorPalette.primaryTeal,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.arrow_forward,
                        size: 12,
                        color: isUpcoming
                            ? ColorPalette.onSurfaceDim
                            : ColorPalette.primaryTeal,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniPill extends StatelessWidget {
  final String label;
  final Color color;
  const _MiniPill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(label, style: AppTextStyles.s9SemiBold.copyWith(color: color)),
    );
  }
}
class _PhotoCard extends StatelessWidget {
  final String label;
  const _PhotoCard({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: ColorPalette.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorPalette.outlineVariant.withValues(alpha: 0.2), width: 1),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(Icons.photo_camera_rounded, size: 28,
                color: ColorPalette.primaryTealFixedDim.withValues(alpha: 0.4)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: ColorPalette.onPrimaryTeal.withValues(alpha: 0.6),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Center(
                child: Text(label,
                    style: AppTextStyles.s9SemiBold.copyWith(
                        color: ColorPalette.onSurface, letterSpacing: 1)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

