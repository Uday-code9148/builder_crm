import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateful_widget.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateless_widget.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/core/router/app_routes.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/confirm_sign_up/confirm_sign_up_cubit.dart';

class ConfirmSignUpPage extends BaseStatelessWidget {
  final String email;

  const ConfirmSignUpPage({required this.email, super.key});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ConfirmSignUpCubit>(),
      child: _OtpView(identifier: email),
    );
  }
}

class _OtpView extends BaseStatefulWidget {
  final String identifier;

  const _OtpView({required this.identifier});

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends BaseState<_OtpView> {
  final List<String> _digits = List.filled(6, '');
  int _resendSeconds = 30;
  late Timer _timer;

  @override
  void onInit() {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
      } else {
        t.cancel();
      }
    });
  }

  @override
  void onDispose() {
    _timer.cancel();
  }

  String get _otpCode => _digits.join();

  bool get _isFilled => !_digits.contains('');

  void _onKey(String key) {
    setState(() {
      final idx = _digits.indexOf('');
      if (idx != -1) _digits[idx] = key;
    });
  }

  void _onDelete() {
    setState(() {
      for (int i = 5; i >= 0; i--) {
        if (_digits[i].isNotEmpty) {
          _digits[i] = '';
          break;
        }
      }
    });
  }

  void _submit() {
    if (_isFilled) {
      context.read<ConfirmSignUpCubit>().confirmSignUp(email: widget.identifier, code: _otpCode);
    }
  }

  void _resend() {
    if (_resendSeconds == 0) {
      context.read<ConfirmSignUpCubit>().resendCode(email: widget.identifier);
      setState(() => _resendSeconds = 30);
      _startTimer();
    }
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocListener<ConfirmSignUpCubit, ConfirmSignUpState>(
      listener: (context, state) {
        if (state.canGoLogin) context.go(Routes.login);
      },
      child: Scaffold(
        backgroundColor: ColorPalette.surface,
        body: SafeArea(
          child: Column(
            children: [
              // Back button
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12),
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: ColorPalette.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorPalette.outlineVariant, width: 1),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 16, color: ColorPalette.onSurface),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              // Icon with glow + badge — matches SVG spec
              SizedBox(
                width: 108,
                height: 108,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer glow ring
                    Container(
                      width: 108,
                      height: 108,
                      decoration: BoxDecoration(color: ColorPalette.primaryTeal.withValues(alpha: 0.12), shape: BoxShape.circle),
                    ),
                    // Inner dark container
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: ColorPalette.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ColorPalette.outlineVariant.withValues(alpha: 0.3), width: 1),
                      ),
                      child: const Icon(Icons.phone_in_talk_rounded, size: 36, color: ColorPalette.primaryTeal),
                    ),
                    // Badge top-right
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: ColorPalette.primaryTeal,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorPalette.surface, width: 3),
                        ),
                        child: const Icon(Icons.message_rounded, size: 12, color: ColorPalette.onPrimaryTeal),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Verify your number',
                style: AppTextStyles.s22SemiBold.copyWith(color: ColorPalette.onSurface, letterSpacing: -0.02 * 22),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTextStyles.s13Regular.copyWith(color: ColorPalette.onSurfaceVariant, height: 1.5),
                    children: [
                      const TextSpan(text: "We've sent a 6-digit code to "),
                      TextSpan(
                        text: widget.identifier,
                        style: AppTextStyles.s13SemiBold.copyWith(color: ColorPalette.onSurface),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // OTP boxes
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (i) => _OtpBox(value: _digits[i])),
                ),
              ),
              const SizedBox(height: 24),
              // Resend timer
              GestureDetector(
                onTap: _resend,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: ColorPalette.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(color: ColorPalette.outlineVariant, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        ImageResources.icResendOtp,
                        width: 14,
                        height: 14,
                        colorFilter: ColorFilter.mode(_resendSeconds > 0 ? ColorPalette.onSurfaceDim : ColorPalette.primaryTeal, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _resendSeconds > 0 ? 'Resend OTP in 0:${_resendSeconds.toString().padLeft(2, '0')}' : 'Resend OTP',
                        style: AppTextStyles.s13Medium.copyWith(color: _resendSeconds > 0 ? ColorPalette.onSurfaceVariant : ColorPalette.primaryTeal),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Continue button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: _isFilled ? _submit : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: _isFilled
                          ? const LinearGradient(
                              colors: [ColorPalette.primaryTeal, ColorPalette.primaryTealContainer],
                              transform: GradientRotation(2.356),
                            )
                          : null,
                      color: _isFilled ? null : ColorPalette.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue',
                          style: AppTextStyles.s15SemiBold.copyWith(color: _isFilled ? ColorPalette.onPrimaryTeal : ColorPalette.onSurfaceDim),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 16, color: _isFilled ? ColorPalette.onPrimaryTeal : ColorPalette.onSurfaceDim),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.pop(),
                child: Text('Use another method', style: AppTextStyles.s13Medium.copyWith(color: ColorPalette.primaryTeal)),
              ),
              // Separator
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Expanded(child: Divider(color: ColorPalette.outlineVariant.withValues(alpha: 0.4), height: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'ARCHITECTURAL CURATOR',
                        style: AppTextStyles.s9Regular.copyWith(color: ColorPalette.outlineVariant, letterSpacing: 2.5),
                      ),
                    ),
                    Expanded(child: Divider(color: ColorPalette.outlineVariant.withValues(alpha: 0.4), height: 1)),
                  ],
                ),
              ),
              const Spacer(),
              // Custom numpad
              _Numpad(onKey: _onKey, onDelete: _onDelete),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  final String value;

  const _OtpBox({required this.value});

  @override
  Widget build(BuildContext context) {
    final filled = value.isNotEmpty;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 46,
      height: 54,
      decoration: BoxDecoration(
        color: filled ? ColorPalette.surfaceContainerHigh : ColorPalette.surfaceContainer,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: filled ? ColorPalette.primaryTeal : ColorPalette.outlineVariant, width: 2),
        boxShadow: filled ? [BoxShadow(color: ColorPalette.primaryTeal.withValues(alpha: 0.2), blurRadius: 0, spreadRadius: 2)] : null,
      ),
      child: Center(
        child: Text(value.isEmpty ? '' : value, style: AppTextStyles.s18SemiBold.copyWith(color: ColorPalette.onSurface, letterSpacing: -0.5)),
      ),
    );
  }
}

class _Numpad extends StatelessWidget {
  final void Function(String) onKey;
  final VoidCallback onDelete;

  const _Numpad({required this.onKey, required this.onDelete});

  static const _rows = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['', '0', 'del'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _rows.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row.map((key) {
            if (key.isEmpty) return const SizedBox(width: 80, height: 56);
            if (key == 'del') {
              return GestureDetector(
                onTap: onDelete,
                child: _NumKey(child: const Icon(Icons.backspace_outlined, size: 20, color: ColorPalette.onSurface)),
              );
            }
            final sub = _subLabel(key);
            return GestureDetector(
              onTap: () => onKey(key),
              child: _NumKey(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(key, style: AppTextStyles.s20Medium.copyWith(color: ColorPalette.onSurface)),
                    if (sub.isNotEmpty) Text(sub, style: AppTextStyles.s9Regular.copyWith(color: ColorPalette.onSurfaceDim, letterSpacing: 1.2)),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  String _subLabel(String key) {
    const m = {'2': 'ABC', '3': 'DEF', '4': 'GHI', '5': 'JKL', '6': 'MNO', '7': 'PQRS', '8': 'TUV', '9': 'WXYZ'};
    return m[key] ?? '';
  }
}

class _NumKey extends StatefulWidget {
  final Widget child;

  const _NumKey({required this.child});

  @override
  State<_NumKey> createState() => _NumKeyState();
}

class _NumKeyState extends State<_NumKey> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 80),
        child: Container(
          width: 80,
          height: 56,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: _pressed ? ColorPalette.surfaceContainerHigh : ColorPalette.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
