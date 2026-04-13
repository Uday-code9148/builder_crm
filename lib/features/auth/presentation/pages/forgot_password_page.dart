import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateful_widget.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateless_widget.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_text_form_field.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/router/app_routes.dart';
import 'package:temp_architecture_app_setup/core/utils/validator_utils.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';

class ForgotPasswordPage extends BaseStatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(create: (_) => getIt<ForgotPasswordCubit>(), child: const _ForgotPasswordView());
  }
}

class _ForgotPasswordView extends BaseStatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends BaseState<_ForgotPasswordView> {
  final _emailFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void onInit() {}

  @override
  Future<void> onInitAsync() async {}

  @override
  void onVisible() {}

  @override
  void onDispose() {
    _emailController.dispose();
  }

  @override
  void onConnectivityChanged(bool isConnected) {}

  @override
  Widget buildContent(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state.canGoResetPassword) context.push(Routes.resetPassword, extra: state.email);
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Forgot Password'),
              leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: () => context.pop()),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Text('Reset Password', style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your email and we\'ll send you a reset code.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.outline),
                  ),
                  const SizedBox(height: 32),
                  AppTextFormField(
                    labelText: 'Email',
                    formKey: _emailFormKey,
                    controller: _emailController,
                    isRequired: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: ValidationUtils.email,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(onPressed: _submit, child: const Text('Send Reset Code')),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _submit() {
    if (_emailFormKey.currentState?.validate() == true) {
      context.read<ForgotPasswordCubit>().sendResetCode(email: _emailController.text.trim());
    }
  }
}
