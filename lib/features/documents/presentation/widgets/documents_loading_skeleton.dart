import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/skeleton.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';

class DocumentsLoadingSkeleton extends StatelessWidget {
  const DocumentsLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 24),
              const Skeleton(height: 48, borderRadius: BorderRadius.all(Radius.circular(10))),
              const SizedBox(height: 16),
              const Skeleton(height: 40, borderRadius: BorderRadius.all(Radius.circular(10))),
              const SizedBox(height: 24),
              const SkeletonLine(widthFactor: 0.45, height: 14),
              const SizedBox(height: 12),
              SkeletonCard(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: List.generate(4, (i) {
                    return Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          child: Row(
                            children: [
                              Skeleton(width: 36, height: 36, borderRadius: BorderRadius.all(Radius.circular(8))),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SkeletonLine(widthFactor: 0.75, height: 12),
                                    SizedBox(height: 6),
                                    SkeletonLine(widthFactor: 0.5, height: 10),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              Skeleton(width: 34, height: 34, borderRadius: BorderRadius.all(Radius.circular(8))),
                            ],
                          ),
                        ),
                        if (i < 3) Divider(height: 1, indent: 56, color: colors.outlineVariant.withValues(alpha: 0.18)),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              const SkeletonLine(widthFactor: 0.5, height: 14),
              const SizedBox(height: 12),
              SkeletonCard(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: List.generate(3, (i) {
                    return Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          child: Row(
                            children: [
                              Skeleton(width: 36, height: 36, borderRadius: BorderRadius.all(Radius.circular(8))),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SkeletonLine(widthFactor: 0.7, height: 12),
                                    SizedBox(height: 6),
                                    SkeletonLine(widthFactor: 0.45, height: 10),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              Skeleton(width: 34, height: 34, borderRadius: BorderRadius.all(Radius.circular(8))),
                            ],
                          ),
                        ),
                        if (i < 2) Divider(height: 1, indent: 56, color: colors.outlineVariant.withValues(alpha: 0.18)),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              const SkeletonLine(widthFactor: 0.55, height: 14),
              const SizedBox(height: 12),
              ...List.generate(
                2,
                (i) => const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: SkeletonCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Skeleton(width: 26, height: 26, borderRadius: BorderRadius.all(Radius.circular(8))),
                        SizedBox(height: 12),
                        SkeletonLine(widthFactor: 0.7, height: 14),
                        SizedBox(height: 8),
                        SkeletonLine(widthFactor: 0.5, height: 10),
                        SizedBox(height: 14),
                        Skeleton(height: 40, borderRadius: BorderRadius.all(Radius.circular(8))),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

