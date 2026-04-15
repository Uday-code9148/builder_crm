import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateful_widget.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateless_widget.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_text_form_field.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/router/app_routes.dart';
import 'package:temp_architecture_app_setup/core/utils/validator_utils.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/sign_in/sign_in_cubit.dart';

class SignInPage extends BaseStatelessWidget {
  const SignInPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(create: (_) => getIt<SignInCubit>(), child: const _SignInView());
  }
}

class _SignInView extends BaseStatefulWidget {
  const _SignInView();

  @override
  State<_SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends BaseState<_SignInView> {
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void onInit() {}

  @override
  Future<void> onInitAsync() async {}

  @override
  void onVisible() {}

  @override
  void onDispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void onConnectivityChanged(bool isConnected) {}

  @override
  Widget buildContent(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.canGoHome) {
          context.go(Routes.home);
        } else if (state.needsConfirmation && state.confirmEmail != null) {
          context.push(Routes.confirmSignUp, extra: state.confirmEmail);
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Sign In'),
            leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: () => context.pop()),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Text('Welcome back', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 8),
                Text(
                  'Sign in to your account',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.outline),
                ),
                const SizedBox(height: 32),
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
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: () => context.push(Routes.forgotPassword), child: const Text('Forgot Password?')),
                ),
                const SizedBox(height: 24),
                ElevatedButton(onPressed: _submit, child: const Text('Sign In')),
                const SizedBox(height: 16),
                TextButton(onPressed: () => context.push(Routes.signUp), child: const Text("Don't have an account? Sign Up")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final isValid = [_emailFormKey, _passwordFormKey].every((k) => k.currentState?.validate() == true);
    if (isValid) {
      context.read<SignInCubit>().signIn(email: _emailController.text.trim(), password: _passwordController.text);
    }
  }
}
