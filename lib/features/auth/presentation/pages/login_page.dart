import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/core/router/app_routes.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/sign_in/sign_in_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignInCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.canGoHome) context.go(Routes.home);
        if (state.needsConfirmation && state.confirmEmail != null) {
          context.push(Routes.confirmSignUp, extra: state.confirmEmail);
        }
      },
      child: Scaffold(
        backgroundColor: ColorPalette.surface,
        body: Stack(
          children: [
            // Background gradient — emerald fade from top
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorPalette.primaryTealFixed.withValues(alpha: 0.30),
                      ColorPalette.surface,
                    ],
                    stops: const [0.0, 0.55],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 48),
                    // PH icon
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: ColorPalette.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: ColorPalette.outlineVariant.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'PH',
                            style: AppTextStyles.s18Bold.copyWith(
                              color: ColorPalette.primaryTeal,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Welcome to\nPrestige Homes',
                      style: AppTextStyles.s24Bold.copyWith(
                        color: ColorPalette.onSurface,
                        letterSpacing: -0.02 * 24,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Curation of architectural\nmasterpieces awaits.',
                      style: AppTextStyles.s14Regular.copyWith(
                        color: ColorPalette.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Phone number field
                    _PhoneField(controller: _phoneController),
                    const SizedBox(height: 16),
                    // Send OTP button
                    _GradientButton(
                      label: 'Send OTP',
                      onTap: () {
                        if (_phoneController.text.trim().isNotEmpty) {
                          context.push(
                            Routes.confirmSignUp,
                            extra: _phoneController.text.trim(),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    // Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: ColorPalette.outlineVariant.withValues(alpha: 0.4), height: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or',
                            style: AppTextStyles.s13Regular.copyWith(color: ColorPalette.onSurfaceDim),
                          ),
                        ),
                        Expanded(child: Divider(color: ColorPalette.outlineVariant.withValues(alpha: 0.4), height: 1)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Sign in with Email
                    _OutlineButton(
                      label: 'Sign in with Email',
                      icon: Icons.email_outlined,
                      onTap: () => context.push(Routes.signIn),
                    ),
                    const SizedBox(height: 32),
                    // Terms
                    Text(
                      'By continuing, you agree to our Terms of Service and Privacy Policy. Prestige Homes is a licensed architectural curator.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.s11Regular.copyWith(
                        color: ColorPalette.onSurfaceDim,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // City names
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _CityLabel('LONDON'),
                        _CityDivider(),
                        _CityLabel('DUBAI'),
                        _CityDivider(),
                        _CityLabel('MUMBAI'),
                      ],
                    ),
                    const SizedBox(height: 32),
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

class _PhoneField extends StatelessWidget {
  final TextEditingController controller;
  const _PhoneField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: ColorPalette.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorPalette.outlineVariant, width: 1),
      ),
      child: Row(
        children: [
          // Country code
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: ColorPalette.outlineVariant, width: 1)),
            ),
            child: Text(
              '+91',
              style: AppTextStyles.s14Medium.copyWith(color: ColorPalette.onSurface),
            ),
          ),
          // Phone input
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
              style: AppTextStyles.s14Regular.copyWith(color: ColorPalette.onSurface),
              decoration: InputDecoration(
                hintText: 'Phone number',
                hintStyle: AppTextStyles.s14Regular.copyWith(color: ColorPalette.onSurfaceDim),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                filled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _GradientButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [ColorPalette.primaryTeal, ColorPalette.primaryTealContainer],
              transform: GradientRotation(2.356), // 135°
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: ColorPalette.onPrimaryTeal.withValues(alpha: 0.25),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.s15SemiBold.copyWith(color: ColorPalette.onPrimaryTeal),
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _OutlineButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: ColorPalette.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorPalette.outlineVariant, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: ColorPalette.primaryTeal),
            const SizedBox(width: 10),
            Text(
              label,
              style: AppTextStyles.s14Medium.copyWith(color: ColorPalette.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}

class _CityLabel extends StatelessWidget {
  final String city;
  const _CityLabel(this.city);

  @override
  Widget build(BuildContext context) {
    return Text(
      city,
      style: AppTextStyles.s10Regular.copyWith(
        color: ColorPalette.onSurfaceDim,
        letterSpacing: 2.0,
      ),
    );
  }
}

class _CityDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text('·', style: AppTextStyles.s10Regular.copyWith(color: ColorPalette.outlineVariant)),
    );
  }
}
