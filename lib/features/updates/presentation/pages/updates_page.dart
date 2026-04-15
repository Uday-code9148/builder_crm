import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateful_widget.dart';
import 'package:temp_architecture_app_setup/core/common/constants/app_display_constants.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/curator_glass_app_bar.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/enums/data_status.dart';
import 'package:temp_architecture_app_setup/core/enums/milestone_status.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/entities/milestone_entity.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/entities/project_progress_entity.dart';
import 'package:temp_architecture_app_setup/features/updates/presentation/bloc/updates_bloc/updates_bloc.dart';
import 'package:temp_architecture_app_setup/features/updates/presentation/widgets/updates_loading_skeleton.dart';

// ── Page ─────────────────────────────────────────────────────────────────

class UpdatesPage extends BaseStatefulWidget {
  final String headerTitle;
  final String? headerSubtitle;

  const UpdatesPage({super.key, this.headerTitle = AppDisplayConstants.appTitle, this.headerSubtitle});

  @override
  State<UpdatesPage> createState() => _UpdatesPageState();
}

class _UpdatesPageState extends BaseState<UpdatesPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // required by AutomaticKeepAliveClientMixin
    return buildContent(context);
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UpdatesBloc>()..add(const UpdatesLoadRequested()),
      child: BlocBuilder<UpdatesBloc, UpdatesState>(
        builder: (context, state) {
          return Scaffold(backgroundColor: context.colors.surface, appBar: _buildAppBar(), body: _buildBody(state));
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return buildCuratorGlassAppBar(context: context, title: widget.headerTitle, subtitle: widget.headerSubtitle);
  }

  Widget _buildBody(UpdatesState state) {
    final colors = context.colors;
    if (state.status == DataStatus.loading) {
      return const UpdatesLoadingSkeleton();
    }
    if (state.status == DataStatus.error) {
      return Center(
        child: Text(state.error ?? 'Something went wrong', style: AppTextStyles.s13Regular.copyWith(color: colors.onSurfaceVariant)),
      );
    }
    if (state.data == null) return const SizedBox.shrink();

    final data = state.data!;

    return RefreshIndicator(
      color: colors.primaryTeal,
      notificationPredicate: (n) => n.depth == 0,
      onRefresh: () async {
        final bloc = context.read<UpdatesBloc>();
        bloc.add(const UpdatesLoadRequested());
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
                _buildProgressHero(data),
                const SizedBox(height: 24),
                _buildMilestoneList(data.milestones ?? const <MilestoneEntity>[]),
                const SizedBox(height: 24),
                _buildLatestPhotos(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressHero(ProjectProgressEntity data) {
    final colors = context.colors;
    final overallProgress = data.overallProgress ?? 0;
    final pct = (overallProgress * 100).toInt();
    return Column(
      children: [
        SizedBox(
          width: 196,
          height: 196,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: overallProgress,
                strokeWidth: 10,
                backgroundColor: colors.surfaceContainerHigh,
                valueColor: AlwaysStoppedAnimation<Color>(colors.primaryTeal),
                strokeCap: StrokeCap.round,
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$pct%',
                      style: AppTextStyles.s24Bold.copyWith(fontSize: 40, fontWeight: FontWeight.w900, color: colors.onSurface, letterSpacing: -1),
                    ),
                    const SizedBox(height: 2),
                    Text('TOTAL PROGRESS', style: AppTextStyles.s9Regular.copyWith(color: colors.onSurfaceDim, letterSpacing: 1.2)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(data.projectName ?? '--', style: AppTextStyles.s22SemiBold.copyWith(color: colors.onSurface, letterSpacing: -0.4)),
        const SizedBox(height: 4),
        Text(data.unit ?? '--', style: AppTextStyles.s13Regular.copyWith(color: colors.onSurfaceVariant)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(99),
            border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.4), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.access_time_rounded, size: 11, color: colors.onSurfaceDim),
              const SizedBox(width: 4),
              Text('Updated ${data.lastUpdated ?? '--'}', style: AppTextStyles.s11Regular.copyWith(color: colors.onSurfaceDim)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMilestoneList(List<MilestoneEntity> milestones) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Milestones', style: AppTextStyles.s22SemiBold.copyWith(color: colors.onSurface, letterSpacing: -0.3)),
        const SizedBox(height: 16),
        ...List.generate(milestones.length, (i) {
          return _TimelineTile(milestone: milestones[i], isLast: i == milestones.length - 1);
        }),
      ],
    );
  }

  Widget _buildLatestPhotos() {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Latest Photos', style: AppTextStyles.s14SemiBold.copyWith(color: colors.onSurface)),
            const Spacer(),
            Text('See All', style: AppTextStyles.s12Medium.copyWith(color: colors.primaryTeal)),
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

class _TimelineTile extends StatelessWidget {
  final MilestoneEntity milestone;
  final bool isLast;

  const _TimelineTile({required this.milestone, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final status = milestone.status ?? MilestoneStatus.upcoming;
    final progress = milestone.progress ?? 0;
    final isDone = status == MilestoneStatus.done;
    final isInProgress = status == MilestoneStatus.inProgress;
    final isUpcoming = status == MilestoneStatus.upcoming;
    final nodeColor = status.nodeColor(colors);
    final progressPct = '${(progress * 100).toInt()}%';

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isDone
                        ? colors.primaryTeal
                        : isInProgress
                        ? colors.surfaceContainerHighest
                        : colors.surfaceContainerLow,
                    shape: BoxShape.circle,
                    border: Border.all(color: nodeColor, width: isDone ? 0 : (isInProgress ? 2 : 1)),
                  ),
                  child: isDone
                      ? Icon(Icons.check_rounded, size: 13, color: colors.onPrimaryTeal)
                      : isInProgress
                      ? Center(
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(color: nodeColor, shape: BoxShape.circle),
                          ),
                        )
                      : Center(
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(color: colors.outlineVariant.withValues(alpha: 0.5), shape: BoxShape.circle),
                          ),
                        ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isDone ? colors.primaryTeal.withValues(alpha: 0.35) : colors.outlineVariant.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUpcoming ? colors.surfaceContainerLow : colors.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDone ? colors.primaryTeal.withValues(alpha: 0.2) : colors.outlineVariant.withValues(alpha: 0.1),
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
                          milestone.title ?? '--',
                          style: AppTextStyles.s13SemiBold.copyWith(color: isUpcoming ? colors.onSurfaceDim : colors.onSurface),
                        ),
                      ),
                      if (isInProgress)
                        _MiniPill(label: 'In Progress', color: colors.warningAmber)
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(color: colors.surfaceContainerHighest, borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            progressPct,
                            style: AppTextStyles.s11SemiBold.copyWith(color: isDone ? colors.primaryTeal : colors.onSurfaceDim),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(milestone.subtitle ?? '--', style: AppTextStyles.s11Regular.copyWith(color: colors.onSurfaceDim)),
                  if (isInProgress) ...[
                    const SizedBox(height: 10),
                    Stack(
                      children: [
                        Container(
                          height: 6,
                          decoration: BoxDecoration(color: colors.surfaceContainerHigh, borderRadius: BorderRadius.circular(99)),
                        ),
                        FractionallySizedBox(
                          widthFactor: progress,
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [colors.primaryTeal, colors.primaryTealContainer]),
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
                      Text('View Photos', style: AppTextStyles.s12Medium.copyWith(color: isUpcoming ? colors.onSurfaceDim : colors.primaryTeal)),
                      const SizedBox(width: 2),
                      Icon(Icons.arrow_forward, size: 12, color: isUpcoming ? colors.onSurfaceDim : colors.primaryTeal),
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
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(99)),
      child: Text(label, style: AppTextStyles.s9SemiBold.copyWith(color: color)),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  final String label;

  const _PhotoCard({required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.2), width: 1),
      ),
      child: Stack(
        children: [
          Center(child: Icon(Icons.photo_camera_rounded, size: 28, color: ColorPalette.primaryTealFixedDim.withValues(alpha: 0.4))),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: colors.onPrimaryTeal.withValues(alpha: 0.6),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Center(
                child: Text(label, style: AppTextStyles.s9SemiBold.copyWith(color: colors.onSurface, letterSpacing: 1)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
