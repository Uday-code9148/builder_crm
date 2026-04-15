import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/skeleton.dart';

class DashboardLoadingSkeletonSliver extends StatelessWidget {
  const DashboardLoadingSkeletonSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          const SizedBox(height: 24),
          const SkeletonLine(widthFactor: 0.55, height: 22),
          const SizedBox(height: 8),
          const SkeletonLine(widthFactor: 0.7, height: 12),
          const SizedBox(height: 16),
          SkeletonCard(
            child: Row(
              children: const [
                Skeleton.circle(size: 42),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonLine(widthFactor: 0.6, height: 12),
                      SizedBox(height: 8),
                      SkeletonLine(widthFactor: 0.8, height: 10),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Skeleton(width: 64, height: 30, borderRadius: BorderRadius.all(Radius.circular(8))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SkeletonCard(
            child: Row(
              children: const [
                Skeleton.circle(size: 88),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      SkeletonLine(widthFactor: 1, height: 10),
                      SizedBox(height: 10),
                      SkeletonLine(widthFactor: 0.85, height: 10),
                      SizedBox(height: 10),
                      SkeletonLine(widthFactor: 0.7, height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(
              4,
              (i) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i == 3 ? 0 : 8),
                  child: const Skeleton(height: 74, borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Skeleton(height: 220, borderRadius: BorderRadius.all(Radius.circular(14))),
          const SizedBox(height: 16),
          const Skeleton(height: 200, borderRadius: BorderRadius.all(Radius.circular(14))),
          const SizedBox(height: 16),
          SkeletonCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLine(widthFactor: 0.45, height: 14),
                const SizedBox(height: 14),
                ...List.generate(
                  4,
                  (i) => Padding(
                    padding: EdgeInsets.only(bottom: i == 3 ? 0 : 12),
                    child: const Row(
                      children: [
                        Skeleton(width: 38, height: 38, borderRadius: BorderRadius.all(Radius.circular(10))),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SkeletonLine(widthFactor: 0.65, height: 12),
                              SizedBox(height: 6),
                              SkeletonLine(widthFactor: 0.45, height: 10),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Skeleton(width: 44, height: 10, borderRadius: BorderRadius.all(Radius.circular(8))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

