import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/skeleton.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';

class PaymentsLoadingSkeleton extends StatelessWidget {
  const PaymentsLoadingSkeleton({super.key});

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
              const SizedBox(height: 20),
              SkeletonCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SkeletonLine(widthFactor: 0.45, height: 10),
                    const SizedBox(height: 10),
                    const Skeleton(width: 190, height: 34, borderRadius: BorderRadius.all(Radius.circular(10))),
                    const SizedBox(height: 18),
                    const Row(
                      children: [
                        Expanded(child: SkeletonLine(widthFactor: 0.55, height: 12)),
                        SizedBox(width: 16),
                        Expanded(child: SkeletonLine(widthFactor: 0.5, height: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (_, i) => const SizedBox(width: 8),
                  itemBuilder: (_, i) => const Skeleton(width: 86, height: 32, borderRadius: BorderRadius.all(Radius.circular(99))),
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
                          Skeleton(width: 6, height: 72, borderRadius: BorderRadius.all(Radius.circular(6))),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SkeletonLine(widthFactor: 0.7, height: 14),
                                SizedBox(height: 8),
                                SkeletonLine(widthFactor: 0.55, height: 10),
                                SizedBox(height: 14),
                                SkeletonLine(widthFactor: 0.4, height: 12),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Skeleton(width: 60, height: 18, borderRadius: BorderRadius.all(Radius.circular(99))),
                              SizedBox(height: 18),
                              Skeleton(width: 64, height: 10, borderRadius: BorderRadius.all(Radius.circular(8))),
                            ],
                          ),
                        ],
                      ),
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

