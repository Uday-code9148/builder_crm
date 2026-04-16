import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateful_widget.dart';
import 'package:temp_architecture_app_setup/core/common/constants/app_display_constants.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/curator_glass_app_bar.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/enums/data_status.dart';
import 'package:temp_architecture_app_setup/core/router/app_router.dart';
import 'package:temp_architecture_app_setup/core/router/app_routes.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/features/documents/presentation/blocs/documents_bloc/documents_bloc.dart';
import 'package:temp_architecture_app_setup/features/documents/presentation/helpers/documents_view_model.dart';
import 'package:temp_architecture_app_setup/features/documents/presentation/widgets/documents_loading_skeleton.dart';

// ── Page ─────────────────────────────────────────────────────────────────

class DocumentsPage extends BaseStatefulWidget {
  final String headerTitle;
  final String? headerSubtitle;

  const DocumentsPage({super.key, this.headerTitle = AppDisplayConstants.appTitle, this.headerSubtitle});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends BaseState<DocumentsPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildContent(context);
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DocumentsBloc>()..add(const DocumentsLoadRequested()),
      child: BlocBuilder<DocumentsBloc, DocumentsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.colors.surface,
            appBar: _buildAppBar(),
            floatingActionButton: const _GradientFab(),
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return buildCuratorGlassAppBar(context: context, title: widget.headerTitle, subtitle: widget.headerSubtitle);
  }

  Widget _buildBody(DocumentsState state) {
    final colors = context.colors;
    if (state.status == DataStatus.loading) return const DocumentsLoadingSkeleton();
    if (state.status == DataStatus.error) {
      return Center(
        child: Text(state.error ?? 'Something went wrong', style: AppTextStyles.s13Regular.copyWith(color: colors.onSurfaceVariant)),
      );
    }
    if (state.viewModel == null) return const SizedBox.shrink();

    final vm = state.viewModel!;

    return RefreshIndicator(
      color: colors.primaryTeal,
      notificationPredicate: (n) => n.depth == 0,
      onRefresh: () async {
        final bloc = context.read<DocumentsBloc>();
        bloc.add(const DocumentsLoadRequested());
        try {
          await bloc.stream.firstWhere((s) => s.status != DataStatus.loading).timeout(const Duration(seconds: 12));
        } catch (_) {}
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 24),
                _buildSearch(),
                const SizedBox(height: 16),
                _buildTabs(),
                const SizedBox(height: 24),
                _buildSection(title: 'Legal Documents', accentColor: ColorPalette.secondaryPurple, items: vm.legalDocs),
                const SizedBox(height: 20),
                _buildSection(title: 'Payment & Finance', accentColor: colors.primaryTeal, items: vm.paymentDocs),
                const SizedBox(height: 20),
                _buildCertSection(vm.certificates),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    final colors = context.colors;
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colors.outlineVariant, width: 1),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          SvgPicture.asset(ImageResources.icSearch, width: 18, height: 18, colorFilter: ColorFilter.mode(colors.onSurfaceDim, BlendMode.srcIn)),
          const SizedBox(width: 10),
          Expanded(
            child: Text('Search architectural plans, contract…', style: AppTextStyles.s13Regular.copyWith(color: colors.onSurfaceDim)),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final colors = context.colors;
    const tabs = ['Builder Documents', 'My Uploads'];
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colors.outlineVariant, width: 1),
      ),
      child: Row(
        children: List.generate(2, (i) {
          final selected = i == _tabIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _tabIndex = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: selected ? colors.primaryTealContainer.withValues(alpha: 0.25) : ColorPalette.transparent,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(tabs[i], style: AppTextStyles.s12Medium.copyWith(color: selected ? colors.primaryTeal : colors.onSurfaceVariant)),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSection({required String title, required Color accentColor, required List<DocItemVM> items}) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 6, height: 22, decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(99))),
            const SizedBox(width: 10),
            Text(title, style: AppTextStyles.s14SemiBold.copyWith(color: colors.onSurface)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: colors.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15), width: 1),
          ),
          child: Column(
            children: List.generate(items.length, (i) {
              return Column(
                children: [
                  _DocRowTile(item: items[i], onTap: () => appRouter.push(Routes.documentDetails, extra: items[i])),
                  if (i < items.length - 1) Divider(height: 1, indent: 56, color: colors.outlineVariant.withValues(alpha: 0.2)),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildCertSection(List<CertDocVM> certs) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 6, height: 22, decoration: BoxDecoration(color: colors.tertiaryTeal, borderRadius: BorderRadius.circular(99))),
            const SizedBox(width: 10),
            Text('Certificates & Compliance', style: AppTextStyles.s14SemiBold.copyWith(color: colors.onSurface)),
          ],
        ),
        ...certs.map((c) => _CertCard(doc: c, onTap: () => appRouter.push(Routes.documentDetails, extra: c))),
      ],
    );
  }
}

class _DocRowTile extends StatelessWidget {
  final DocItemVM item;
  final VoidCallback onTap;

  const _DocRowTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: colors.surfaceContainerHigh, borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: SvgPicture.asset(
                  item.iconAsset,
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(ColorPalette.primaryTealFixedDim, BlendMode.srcIn),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: AppTextStyles.s13Medium.copyWith(color: colors.onSurface)),
                  if (item.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(item.subtitle!, style: AppTextStyles.s11Regular.copyWith(color: colors.onSurfaceDim)),
                  ],
                ],
              ),
            ),
            if (item.statusLabel != null && item.statusColor != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: item.statusColor!.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(99)),
                child: Text(item.statusLabel!, style: AppTextStyles.s10SemiBold.copyWith(color: item.statusColor!)),
              ),
              const SizedBox(width: 8),
            ],
            const SizedBox(width: 4),
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(color: colors.surfaceContainerHigh, borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: SvgPicture.asset(
                  ImageResources.icDownload,
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(colors.primaryTeal, BlendMode.srcIn),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CertCard extends StatelessWidget {
  final CertDocVM doc;
  final VoidCallback onTap;

  const _CertCard({required this.doc, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: doc.accent.withValues(alpha: 0.07),
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(56)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(doc.iconAsset, width: 26, height: 26, colorFilter: ColorFilter.mode(doc.accent, BlendMode.srcIn)),
                  const SizedBox(height: 12),
                  Text(doc.title, style: AppTextStyles.s14SemiBold.copyWith(color: colors.onSurface)),
                  const SizedBox(height: 3),
                  Text(doc.subtitle, style: AppTextStyles.s12Regular.copyWith(color: colors.onSurfaceVariant)),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: onTap,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: colors.outlineVariant),
                      ),
                      child: Center(
                        child: Text('View Certificate', style: AppTextStyles.s13Medium.copyWith(color: doc.accent)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GradientFab extends StatelessWidget {
  const _GradientFab();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [colors.primaryTeal, colors.primaryTealContainer], transform: const GradientRotation(2.356)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: colors.primaryTeal.withValues(alpha: 0.25), blurRadius: 24, offset: const Offset(0, 8))],
      ),
      child: Center(
        child: SvgPicture.asset(
          ImageResources.icNewDocUploaded,
          width: 26,
          height: 26,
          colorFilter: ColorFilter.mode(colors.onPrimaryTeal, BlendMode.srcIn),
        ),
      ),
    );
  }
}
