import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateful_widget.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateless_widget.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_text_form_field.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/router/app_routes.dart';
import 'package:temp_architecture_app_setup/core/utils/validator_utils.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/sign_up/sign_up_cubit.dart';

class SignUpPage extends BaseStatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(create: (_) => getIt<SignUpCubit>(), child: const _SignUpView());
  }
}

class _SignUpView extends BaseStatefulWidget {
  const _SignUpView();

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends BaseState<_SignUpView> {
  final _nameController = TextEditingController();

  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _confirmPasswordFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  void onConnectivityChanged(bool isConnected) {}

  @override
  Widget buildContent(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        context.push(Routes.confirmSignUp, extra: state.email);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Create Account'),
            leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: () => context.pop()),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Text('Join us today', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 8),
                Text(
                  'Fill in the details below to get started',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.outline),
                ),
                const SizedBox(height: 32),
                AppTextFormField(labelText: 'Full Name', controller: _nameController, keyboardType: TextInputType.name),
                const SizedBox(height: 16),
                AppTextFormField(
                  labelText: 'Email',
                  controller: _emailController,
                  formKey: _emailFormKey,
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidationUtils.email,
                ),
                const SizedBox(height: 16),
                AppTextFormField(
                  labelText: 'Password',
                  controller: _passwordController,
                  formKey: _passwordFormKey,
                  isRequired: true,
                  isObscureText: true,
                  validator: (v) => ValidationUtils.minLength(v, 8, 'Password'),
                ),
                const SizedBox(height: 16),
                AppTextFormField(
                  labelText: 'Confirm Password',
                  controller: _confirmPasswordController,
                  formKey: _confirmPasswordFormKey,
                  isRequired: true,
                  isObscureText: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please confirm your password';
                    if (v != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(onPressed: _submit, child: const Text('Create Account')),
                const SizedBox(height: 16),
                TextButton(onPressed: () => context.pop(), child: const Text('Already have an account? Sign In')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final isValid = [_emailFormKey, _passwordFormKey, _confirmPasswordFormKey].every((k) => k.currentState?.validate() == true);

    if (isValid) {
      context.read<SignUpCubit>().signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim().isNotEmpty ? _nameController.text.trim() : null,
      );
    }
  }
}
