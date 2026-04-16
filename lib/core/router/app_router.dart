import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:temp_architecture_app_setup/core/common/pages/document_details_page.dart';
import 'package:temp_architecture_app_setup/core/router/app_routes.dart';
import 'package:temp_architecture_app_setup/core/router/route_observer.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/pages/confirm_sign_up_page.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/pages/login_page.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/pages/reset_password_page.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/pages/sign_in_page.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/pages/sign_up_page.dart';
import 'package:temp_architecture_app_setup/features/auth/presentation/pages/splash_page.dart';
import 'package:temp_architecture_app_setup/features/documents/presentation/helpers/documents_view_model.dart';
import 'package:temp_architecture_app_setup/features/home/presentation/pages/home_page.dart';
import 'package:temp_architecture_app_setup/features/support/presentation/blocs/create_ticket_bloc/create_ticket_bloc.dart';
import 'package:temp_architecture_app_setup/features/support/presentation/pages/new_ticket_page.dart';
import 'package:temp_architecture_app_setup/features/updates/presentation/pages/updates_page.dart';
import 'package:temp_architecture_app_setup/main.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: MyApp.navigatorKey,
  observers: [routeObserver],
  initialLocation: Routes.splash,
  routes: [
    GoRoute(path: Routes.splash, builder: (context, state) => const SplashPage()),
    GoRoute(path: Routes.login, builder: (context, state) => const LoginPage()),
    GoRoute(path: Routes.signIn, builder: (context, state) => const SignInPage()),
    GoRoute(path: Routes.signUp, builder: (context, state) => const SignUpPage()),
    GoRoute(
      path: Routes.confirmSignUp,
      builder: (context, state) => ConfirmSignUpPage(email: state.extra as String? ?? ''),
    ),
    GoRoute(path: Routes.forgotPassword, builder: (context, state) => const ForgotPasswordPage()),
    GoRoute(
      path: Routes.resetPassword,
      builder: (context, state) => ResetPasswordPage(email: state.extra as String? ?? ''),
    ),
    GoRoute(path: Routes.home, builder: (context, state) => const HomePage()),
    GoRoute(path: Routes.updates, builder: (context, state) => const UpdatesPage()),
    GoRoute(
      path: Routes.documentDetails,
      builder: (context, state) {
        final extra = state.extra;
        if (extra is DocItemVM) {
          return DocumentDetailsPage(
            title: extra.title,
            subtitle: extra.subtitle,
            categoryLabel: extra.categoryLabel,
            statusLabel: extra.statusLabel,
            fileUrl: extra.fileUrl,
          );
        }
        if (extra is CertDocVM) {
          return DocumentDetailsPage(title: extra.title, subtitle: extra.subtitle, categoryLabel: 'Certificate & Compliance', fileUrl: extra.fileUrl);
        }
        return const DocumentDetailsPage();
      },
    ),
    GoRoute(
      path: Routes.newTicket,
      builder: (context, state) => BlocProvider(create: (_) => CreateTicketBloc(), child: const NewTicketPage()),
    ),
  ],
);
