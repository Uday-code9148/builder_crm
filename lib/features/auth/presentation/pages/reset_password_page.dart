import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateful_widget.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateless_widget.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_text_form_field.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/router/app_routes.dart';
import 'package:temp_architecture_app_setup/core/utils/validator_utils.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';

class ResetPasswordPage extends BaseStatelessWidget {
  final String email;

  const ResetPasswordPage({super.key, required this.email});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ResetPasswordCubit>(),
      child: _ResetPasswordView(email: email),
    );
  }
}

class _ResetPasswordView extends BaseStatefulWidget {
  final String email;

  const _ResetPasswordView({required this.email});

  @override
  State<_ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends BaseState<_ResetPasswordView> {
  final _codeFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _confirmPasswordFormKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void onInit() {}

  @override
  Future<void> onInitAsync() async {}

  @override
  void onVisible() {}

  @override
  void onDispose() {
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  void onConnectivityChanged(bool isConnected) {}

  @override
  Widget buildContent(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listenWhen: (prev, curr) => !prev.canGoLogin && curr.canGoLogin,
      listener: (context, state) {
        context.go(Routes.login);
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Reset Password'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => context.pop(),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Text('Create New Password', style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Enter the code sent to ${widget.email} and your new password.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                  const SizedBox(height: 32),
                  AppTextFormField(
                    labelText: 'Verification Code',
                    formKey: _codeFormKey,
                    controller: _codeController,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                    validator: (v) => ValidationUtils.minLength(v, 6, 'Code'),
                  ),
                  const SizedBox(height: 16),
                  AppTextFormField(
                    labelText: 'New Password',
                    formKey: _passwordFormKey,
                    controller: _passwordController,
                    isRequired: true,
                    isObscureText: true,
                    validator: (v) => ValidationUtils.minLength(v, 8, 'Password'),
                  ),
                  const SizedBox(height: 16),
                  AppTextFormField(
                    labelText: 'Confirm New Password',
                    formKey: _confirmPasswordFormKey,
                    controller: _confirmPasswordController,
                    isRequired: true,
                    isObscureText: true,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Please confirm your password';
                      if (v != _passwordController.text) return 'Passwords do not match';
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Reset Password'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _submit() {
    final isValid = [_codeFormKey, _passwordFormKey, _confirmPasswordFormKey]
        .every((k) => k.currentState?.validate() == true);
    if (isValid) {
      context.read<ResetPasswordCubit>().resetPassword(
            email: widget.email,
            code: _codeController.text.trim(),
            newPassword: _passwordController.text,
          );
    }
  }
}
