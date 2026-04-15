import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/skeleton.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';

class SupportLoadingSkeleton extends StatelessWidget {
  const SupportLoadingSkeleton({super.key});

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
              const SkeletonLine(widthFactor: 0.55, height: 28),
              const SizedBox(height: 10),
              const SkeletonLine(widthFactor: 0.9, height: 12),
              const SizedBox(height: 16),
              const Skeleton(height: 48, borderRadius: BorderRadius.all(Radius.circular(10))),
              const SizedBox(height: 20),
              SizedBox(
                height: 34,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  separatorBuilder: (_, i) => const SizedBox(width: 8),
                  itemBuilder: (_, i) => const Skeleton(width: 86, height: 28, borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
              const SizedBox(height: 16),
              ...List.generate(
                5,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.surfaceContainer,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.12)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Skeleton(width: 6, height: 84, borderRadius: BorderRadius.all(Radius.circular(6))),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Skeleton(width: 64, height: 18, borderRadius: BorderRadius.all(Radius.circular(6))),
                                SizedBox(height: 10),
                                SkeletonLine(widthFactor: 0.75, height: 14),
                                SizedBox(height: 8),
                                SkeletonLine(widthFactor: 0.6, height: 10),
                                SizedBox(height: 16),
                                SkeletonLine(widthFactor: 0.35, height: 12),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.center,
                child: Skeleton(width: 170, height: 44, borderRadius: BorderRadius.all(Radius.circular(99))),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
