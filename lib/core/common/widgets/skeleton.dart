import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';

/// Lightweight, theme-aware skeleton building blocks.
///
/// Intentionally shimmer-less to keep dependencies low and avoid visual noise.
class Skeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius borderRadius;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? margin;

  const Skeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.shape,
    this.margin,
  });

  const Skeleton.circle({
    super.key,
    double? size,
    this.margin,
  })  : width = size,
        height = size,
        borderRadius = const BorderRadius.all(Radius.circular(999)),
        shape = const CircleBorder();

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _t;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))..repeat(reverse: true);
    _t = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final base = colors.surfaceContainerHigh;
    final highlight = colors.surfaceContainerHighest;

    return AnimatedBuilder(
      animation: _t,
      builder: (context, _) {
        final color = Color.lerp(base, highlight, _t.value) ?? base;
        final child = Container(
          width: widget.width,
          height: widget.height,
          decoration: widget.shape != null
              ? ShapeDecoration(color: color, shape: widget.shape!)
              : BoxDecoration(color: color, borderRadius: widget.borderRadius),
        );
        return widget.margin == null ? child : Padding(padding: widget.margin!, child: child);
      },
    );
  }
}

class SkeletonLine extends StatelessWidget {
  final double widthFactor;
  final double height;
  final BorderRadius borderRadius;

  const SkeletonLine({
    super.key,
    this.widthFactor = 1,
    this.height = 12,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth.isFinite ? (c.maxWidth * widthFactor) : null;
        return Skeleton(width: w, height: height, borderRadius: borderRadius);
      },
    );
  }
}

class SkeletonCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SkeletonCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.15)),
      ),
      child: child,
    );
  }
}

