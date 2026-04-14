import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:temp_architecture_app_setup/core/constants/hive_constants.dart';
import 'package:temp_architecture_app_setup/core/di/injection.dart';
import 'package:temp_architecture_app_setup/core/router/app_router.dart';
import 'package:temp_architecture_app_setup/core/services/amplify_service.dart';
import 'package:temp_architecture_app_setup/core/theme/app_theme.dart';
import 'package:temp_architecture_app_setup/core/theme/cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Storage
  await Hive.initFlutter();
  await Hive.openBox(HiveConstants.settingsBox);

  // Dependency injection
  await configureDependencies();

  // Amplify (after DI so getIt is ready)
  await getIt<AmplifyService>().configure();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            title: 'App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.themeMode,
            routerConfig: appRouter,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
