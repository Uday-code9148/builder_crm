import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/core/router/app_routes.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/splash_cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SplashCubit>()..checkAuthStatus(),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatefulWidget {
  const _SplashView();

  @override
  State<_SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<_SplashView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _fadeAnim = CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeOut));
    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.7, curve: Cubic(0.2, 0.8, 0.2, 1))),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.canGoHome) context.go(Routes.home);
        if (state.canGoLogin) context.go(Routes.login);
      },
      child: Scaffold(
        backgroundColor: ColorPalette.surface,
        body: Stack(
          children: [
            // Radial vignette — deep emerald glow at center
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.85,
                    colors: [
                      ColorPalette.primaryTealFixed.withValues(alpha: 0.18),
                      ColorPalette.surface,
                    ],
                  ),
                ),
              ),
            ),
            // Center content
            Center(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: ScaleTransition(
                  scale: _scaleAnim,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // PH Icon
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          color: ColorPalette.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: ColorPalette.onPrimaryTeal.withValues(alpha: 0.35),
                              blurRadius: 32,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'PH',
                            style: AppTextStyles.s22Bold.copyWith(
                              fontSize: 28,
                              color: ColorPalette.primaryTealFixed,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Prestige Homes',
                        style: AppTextStyles.s22SemiBold.copyWith(
                          color: ColorPalette.onSurface,
                          letterSpacing: -0.02 * 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom branding
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeAnim,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (i) => _Dot(active: i == 0)),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'ARCHITECTURAL CURATOR',
                      style: AppTextStyles.s10Regular.copyWith(
                        color: ColorPalette.onSurfaceDim,
                        letterSpacing: 3.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool active;
  const _Dot({required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: active ? 20 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: active ? ColorPalette.primaryTeal : ColorPalette.outlineVariant,
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }
}

