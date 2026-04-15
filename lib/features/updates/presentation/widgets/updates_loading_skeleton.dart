import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/skeleton.dart';

class UpdatesLoadingSkeleton extends StatelessWidget {
  const UpdatesLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 24),
              Column(
                children: [
                  const Skeleton.circle(size: 196),
                  const SizedBox(height: 24),
                  const SkeletonLine(widthFactor: 0.6, height: 18),
                  const SizedBox(height: 10),
                  const SkeletonLine(widthFactor: 0.35, height: 12),
                  const SizedBox(height: 12),
                  const Skeleton(width: 170, height: 26, borderRadius: BorderRadius.all(Radius.circular(99))),
                ],
              ),
              const SizedBox(height: 24),
              const SkeletonLine(widthFactor: 0.4, height: 18),
              const SizedBox(height: 16),
              ...List.generate(
                4,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const Skeleton.circle(size: 24),
                          if (i < 3) ...[const SizedBox(height: 4), Skeleton(width: 2, height: 92, borderRadius: BorderRadius.circular(1))],
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SkeletonCard(
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: SkeletonLine(widthFactor: 0.65, height: 14)),
                                  SizedBox(width: 12),
                                  Skeleton(width: 46, height: 18, borderRadius: BorderRadius.all(Radius.circular(4))),
                                ],
                              ),
                              SizedBox(height: 10),
                              SkeletonLine(widthFactor: 0.9, height: 10),
                              SizedBox(height: 14),
                              SkeletonLine(widthFactor: 0.35, height: 12),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(children: const [SkeletonLine(widthFactor: 0.35, height: 14), Spacer(), SkeletonLine(widthFactor: 0.2, height: 12)]),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: Skeleton(height: 100, borderRadius: BorderRadius.circular(12))),
                  const SizedBox(width: 12),
                  Expanded(child: Skeleton(height: 100, borderRadius: BorderRadius.circular(12))),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
