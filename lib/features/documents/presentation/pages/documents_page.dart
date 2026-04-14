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
import 'package:temp_architecture_app_setup/features/documents/domain/entity/document.dart';
import 'package:temp_architecture_app_setup/features/documents/presentation/blocs/documents_bloc/documents_bloc.dart';

// ── Status/accent helpers ─────────────────────────────────────────────────

extension _DocStatusUI on DocStatus {
  String? get label {
    switch (this) {
      case DocStatus.verified:
        return 'Verified';
      case DocStatus.pending:
        return 'Pending';
      case DocStatus.none:
        return null;
    }
  }

  Color? get color {
    switch (this) {
      case DocStatus.verified:
        return ColorPalette.primaryTealFixed;
      case DocStatus.pending:
        return ColorPalette.warningAmber;
      case DocStatus.none:
        return null;
    }
  }
}

Color _accentColor(String token) {
  switch (token) {
    case 'secondaryPurple':
      return ColorPalette.secondaryPurple;
    case 'tertiaryTeal':
      return ColorPalette.tertiaryTeal;
    default:
      return ColorPalette.primaryTealFixed;
  }
}

// ── Page ─────────────────────────────────────────────────────────────────

class DocumentsPage extends BaseStatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends BaseState<DocumentsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context); // required by AutomaticKeepAliveClientMixin
    return buildContent(context);
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<DocumentsBloc>()..add(const DocumentsLoadRequested()),
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
    final colors = context.colors;
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
              color: colors.surface.withValues(alpha: 0.92),
              border: Border(
                  bottom: BorderSide(
                      color: colors.outlineVariant.withValues(alpha: 0.3),
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
              color: colors.primaryTealFixed,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: colors.onPrimaryTeal.withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4))
              ],
            ),
            child: Icon(Icons.home_work_rounded,
                size: 18, color: colors.white),
          ),
          const SizedBox(width: 10),
          Text('Architectural Curator',
              style: AppTextStyles.s13SemiBold
                  .copyWith(color: colors.onSurface)),
          const Spacer(),
          Icon(Icons.swap_horiz_rounded,
              color: colors.onSurfaceVariant, size: 20),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildBody(DocumentsState state) {
    final colors = context.colors;
    if (state.status == DataStatus.loading) {
      return Center(
          child: CircularProgressIndicator(
              color: colors.primaryTeal, strokeWidth: 2));
    }
    if (state.status == DataStatus.error) {
      return Center(
          child: Text(state.error ?? 'Something went wrong',
              style: AppTextStyles.s13Regular
                  .copyWith(color: colors.onSurfaceVariant)));
    }
    if (state.data == null) return const SizedBox.shrink();

    final data = state.data!;

    return CustomScrollView(
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
              _buildSection(
                title: 'Legal Documents',
                accentColor: ColorPalette.secondaryPurple,
                items: data.legalDocs,
              ),
              const SizedBox(height: 20),
              _buildSection(
                title: 'Payment & Finance',
                accentColor: colors.primaryTeal,
                items: data.paymentDocs,
              ),
              const SizedBox(height: 20),
              _buildCertSection(data.certificates),
            ]),
          ),
        ),
      ],
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
          SvgPicture.asset(ImageResources.icSearch,
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(
                  colors.onSurfaceDim, BlendMode.srcIn)),
          const SizedBox(width: 10),
          Expanded(
            child: Text('Search architectural plans, contract…',
                style: AppTextStyles.s13Regular
                    .copyWith(color: colors.onSurfaceDim)),
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
                  color: selected
                      ? colors.primaryTealContainer.withValues(alpha: 0.25)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(tabs[i],
                      style: AppTextStyles.s12Medium.copyWith(
                          color: selected
                              ? colors.primaryTeal
                              : colors.onSurfaceVariant)),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Color accentColor,
    required List<DocumentItem> items,
  }) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 22,
              decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(99)),
            ),
            const SizedBox(width: 10),
            Text(title,
                style: AppTextStyles.s14SemiBold
                    .copyWith(color: colors.onSurface)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: colors.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: colors.outlineVariant.withValues(alpha: 0.15),
                width: 1),
          ),
          child: Column(
            children: List.generate(items.length, (i) {
              return Column(
                children: [
                  _DocRowTile(item: items[i]),
                  if (i < items.length - 1)
                    Divider(
                        height: 1,
                        indent: 56,
                        color: colors.outlineVariant.withValues(alpha: 0.2)),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildCertSection(List<CertDocument> certs) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 22,
              decoration: BoxDecoration(
                  color: colors.tertiaryTeal,
                  borderRadius: BorderRadius.circular(99)),
            ),
            const SizedBox(width: 10),
            Text('Certificates & Compliance',
                style: AppTextStyles.s14SemiBold
                    .copyWith(color: colors.onSurface)),
          ],
        ),
        ...certs.map((c) => _CertCard(doc: c)),
      ],
    );
  }
}

class _DocRowTile extends StatelessWidget {
  final DocumentItem item;
  const _DocRowTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final statusLabel = item.status.label;
    final statusColor = item.status.color;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: colors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: SvgPicture.asset(item.iconAsset,
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(
                      ColorPalette.primaryTealFixedDim, BlendMode.srcIn)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,
                    style: AppTextStyles.s13Medium
                        .copyWith(color: colors.onSurface)),
                if (item.subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(item.subtitle,
                      style: AppTextStyles.s11Regular
                          .copyWith(color: colors.onSurfaceDim)),
                ],
              ],
            ),
          ),
          if (statusLabel != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: statusColor!.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(99)),
              child: Text(statusLabel,
                  style:
                      AppTextStyles.s10SemiBold.copyWith(color: statusColor)),
            ),
            const SizedBox(width: 8),
          ],
          const SizedBox(width: 4),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
                color: colors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: SvgPicture.asset(ImageResources.icDownload,
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                      colors.primaryTeal, BlendMode.srcIn)),
            ),
          ),
        ],
      ),
    );
  }
}

class _CertCard extends StatelessWidget {
  final CertDocument doc;
  const _CertCard({required this.doc});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accent = _accentColor(doc.accentTokenName);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: colors.outlineVariant.withValues(alpha: 0.15),
            width: 1),
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
                  color: accent.withValues(alpha: 0.07),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(56)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(doc.iconAsset,
                      width: 26,
                      height: 26,
                      colorFilter:
                          ColorFilter.mode(accent, BlendMode.srcIn)),
                  const SizedBox(height: 12),
                  Text(doc.title,
                      style: AppTextStyles.s14SemiBold
                          .copyWith(color: colors.onSurface)),
                  const SizedBox(height: 3),
                  Text(doc.subtitle,
                      style: AppTextStyles.s12Regular
                          .copyWith(color: colors.onSurfaceVariant)),
                  const SizedBox(height: 14),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: colors.outlineVariant),
                    ),
                    child: Center(
                      child: Text('View Certificate',
                          style: AppTextStyles.s13Medium.copyWith(color: accent)),
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
        gradient: LinearGradient(
          colors: [colors.primaryTeal, colors.primaryTealContainer],
          transform: const GradientRotation(2.356),
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: colors.primaryTeal.withValues(alpha: 0.25),
              blurRadius: 24,
              offset: const Offset(0, 8))
        ],
      ),
      child: Center(
        child: SvgPicture.asset(ImageResources.icNewDocUploaded,
            width: 26,
            height: 26,
            colorFilter: ColorFilter.mode(
                colors.onPrimaryTeal, BlendMode.srcIn)),
      ),
    );
  }
}
