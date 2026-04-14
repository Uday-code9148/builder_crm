// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:temp_architecture_app_setup/core/di/network_module.dart'
    as _i866;
import 'package:temp_architecture_app_setup/core/network/rest_client.dart'
    as _i185;
import 'package:temp_architecture_app_setup/core/services/amplify_service.dart'
    as _i126;
import 'package:temp_architecture_app_setup/core/services/storage_service/hive_service.dart'
    as _i597;
import 'package:temp_architecture_app_setup/core/services/token_service.dart'
    as _i546;
import 'package:temp_architecture_app_setup/core/theme/cubit/theme_cubit.dart'
    as _i1013;
import 'package:temp_architecture_app_setup/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i11;
import 'package:temp_architecture_app_setup/features/auth/data/datasources/auth_remote_datasource_impl.dart'
    as _i411;
import 'package:temp_architecture_app_setup/features/auth/data/repositories/auth_repository_impl.dart'
    as _i32;
import 'package:temp_architecture_app_setup/features/auth/domain/repositories/auth_repository.dart'
    as _i109;
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/check_auth_status_usecase.dart'
    as _i942;
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/confirm_forgot_password_usecase.dart'
    as _i760;
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/confirm_sign_up_usecase.dart'
    as _i76;
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/forgot_password_usecase.dart'
    as _i885;
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/logout_usecase.dart'
    as _i790;
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/resend_sign_up_code_usecase.dart'
    as _i174;
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i128;
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i163;
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/confirm_sign_up/confirm_sign_up_cubit.dart'
    as _i88;
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart'
    as _i576;
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/reset_password/reset_password_cubit.dart'
    as _i276;
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/sign_in/sign_in_cubit.dart'
    as _i705;
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/sign_out/sign_out_cubit.dart'
    as _i752;
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/sign_up/sign_up_cubit.dart'
    as _i852;
import 'package:temp_architecture_app_setup/features/auth/presentation/cubit/splash_cubit/splash_cubit.dart'
    as _i486;
import 'package:temp_architecture_app_setup/features/dashboard/data/datasources/dashboard_datasource.dart'
    as _i558;
import 'package:temp_architecture_app_setup/features/dashboard/data/datasources/dashboard_mock_datasource.dart'
    as _i716;
import 'package:temp_architecture_app_setup/features/dashboard/data/repositories/dashboard_repository_impl.dart'
    as _i336;
import 'package:temp_architecture_app_setup/features/dashboard/domain/repositories/dashboard_repository.dart'
    as _i744;
import 'package:temp_architecture_app_setup/features/dashboard/domain/usecases/get_dashboard_data_usecase.dart'
    as _i760;
import 'package:temp_architecture_app_setup/features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart'
    as _i311;
import 'package:temp_architecture_app_setup/features/documents/data/datasources/documents_datasource.dart'
    as _i912;
import 'package:temp_architecture_app_setup/features/documents/data/datasources/documents_mock_datasource.dart'
    as _i582;
import 'package:temp_architecture_app_setup/features/documents/data/repository/documents_repository_impl.dart'
    as _i13;
import 'package:temp_architecture_app_setup/features/documents/domain/repository/documents_repository.dart'
    as _i143;
import 'package:temp_architecture_app_setup/features/documents/domain/usecases/get_documents_usecase.dart'
    as _i142;
import 'package:temp_architecture_app_setup/features/documents/presentation/blocs/documents_bloc/documents_bloc.dart'
    as _i1033;
import 'package:temp_architecture_app_setup/features/payments/data/datasources/payments_datasource.dart'
    as _i128;
import 'package:temp_architecture_app_setup/features/payments/data/datasources/payments_mock_datasource.dart'
    as _i863;
import 'package:temp_architecture_app_setup/features/payments/data/repositories/payments_repository_impl.dart'
    as _i503;
import 'package:temp_architecture_app_setup/features/payments/domain/repositories/payments_repository.dart'
    as _i733;
import 'package:temp_architecture_app_setup/features/payments/domain/usecases/get_payments_usecase.dart'
    as _i229;
import 'package:temp_architecture_app_setup/features/payments/presentation/blocs/payments_bloc/payment_bloc.dart'
    as _i257;
import 'package:temp_architecture_app_setup/features/support/data/datasources/support_datasource.dart'
    as _i985;
import 'package:temp_architecture_app_setup/features/support/data/datasources/support_mock_datasource.dart'
    as _i855;
import 'package:temp_architecture_app_setup/features/support/data/repository/support_repository_impl.dart'
    as _i993;
import 'package:temp_architecture_app_setup/features/support/domain/repository/support_repository.dart'
    as _i586;
import 'package:temp_architecture_app_setup/features/support/domain/usecase/get_support_tickets_usecase.dart'
    as _i684;
import 'package:temp_architecture_app_setup/features/support/presentation/blocs/support_bloc/support_bloc.dart'
    as _i663;
import 'package:temp_architecture_app_setup/features/updates/data/datasources/updates_datasource.dart'
    as _i350;
import 'package:temp_architecture_app_setup/features/updates/data/datasources/updates_mock_datasource.dart'
    as _i67;
import 'package:temp_architecture_app_setup/features/updates/data/repositories/updates_repository_impl.dart'
    as _i934;
import 'package:temp_architecture_app_setup/features/updates/domain/repositories/updates_repository.dart'
    as _i209;
import 'package:temp_architecture_app_setup/features/updates/domain/usecases/get_project_progress_usecase.dart'
    as _i42;
import 'package:temp_architecture_app_setup/features/updates/presentation/bloc/updates_bloc/updates_bloc.dart'
    as _i319;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.singleton<_i185.RestClient>(() => networkModule.restClient);
    gh.singleton<_i126.AmplifyService>(() => _i126.AmplifyService());
    gh.singleton<_i597.HiveService>(() => _i597.HiveService());
    gh.singleton<_i546.TokenService>(() => const _i546.TokenService());
    gh.singleton<_i1013.ThemeCubit>(
      () => _i1013.ThemeCubit(gh<_i597.HiveService>()),
    );
    gh.lazySingleton<_i558.DashboardDataSource>(
      () => _i716.DashboardMockDataSource(),
    );
    gh.lazySingleton<_i912.DocumentsDataSource>(
      () => _i582.DocumentsMockDataSource(),
    );
    gh.factory<_i11.AuthRemoteDataSource>(
      () => const _i411.AuthRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i985.SupportDataSource>(
      () => _i855.SupportMockDataSource(),
    );
    gh.lazySingleton<_i128.PaymentsDataSource>(
      () => _i863.PaymentsMockDataSource(),
    );
    gh.lazySingleton<_i350.UpdatesDataSource>(
      () => _i67.UpdatesMockDataSource(),
    );
    gh.factory<_i143.DocumentsRepository>(
      () => _i13.DocumentsRepositoryImpl(gh<_i912.DocumentsDataSource>()),
    );
    gh.factory<_i586.SupportRepository>(
      () => _i993.SupportRepositoryImpl(gh<_i985.SupportDataSource>()),
    );
    gh.factory<_i744.DashboardRepository>(
      () => _i336.DashboardRepositoryImpl(gh<_i558.DashboardDataSource>()),
    );
    gh.factory<_i109.AuthRepository>(
      () => _i32.AuthRepositoryImpl(gh<_i11.AuthRemoteDataSource>()),
    );
    gh.factory<_i209.UpdatesRepository>(
      () => _i934.UpdatesRepositoryImpl(gh<_i350.UpdatesDataSource>()),
    );
    gh.factory<_i142.GetDocumentsUseCase>(
      () => _i142.GetDocumentsUseCase(gh<_i143.DocumentsRepository>()),
    );
    gh.factory<_i684.GetSupportTicketsUseCase>(
      () => _i684.GetSupportTicketsUseCase(gh<_i586.SupportRepository>()),
    );
    gh.factory<_i733.PaymentsRepository>(
      () => _i503.PaymentsRepositoryImpl(gh<_i128.PaymentsDataSource>()),
    );
    gh.factory<_i942.CheckAuthStatusUseCase>(
      () => _i942.CheckAuthStatusUseCase(gh<_i109.AuthRepository>()),
    );
    gh.factory<_i760.ConfirmForgotPasswordUseCase>(
      () => _i760.ConfirmForgotPasswordUseCase(gh<_i109.AuthRepository>()),
    );
    gh.factory<_i76.ConfirmSignUpUseCase>(
      () => _i76.ConfirmSignUpUseCase(gh<_i109.AuthRepository>()),
    );
    gh.factory<_i885.ForgotPasswordUseCase>(
      () => _i885.ForgotPasswordUseCase(gh<_i109.AuthRepository>()),
    );
    gh.factory<_i790.SignOutUseCase>(
      () => _i790.SignOutUseCase(gh<_i109.AuthRepository>()),
    );
    gh.factory<_i174.ResendSignUpCodeUseCase>(
      () => _i174.ResendSignUpCodeUseCase(gh<_i109.AuthRepository>()),
    );
    gh.factory<_i128.SignInUseCase>(
      () => _i128.SignInUseCase(gh<_i109.AuthRepository>()),
    );
    gh.factory<_i163.SignUpUseCase>(
      () => _i163.SignUpUseCase(gh<_i109.AuthRepository>()),
    );
    gh.factory<_i760.GetDashboardDataUseCase>(
      () => _i760.GetDashboardDataUseCase(gh<_i744.DashboardRepository>()),
    );
    gh.factory<_i752.SignOutCubit>(
      () => _i752.SignOutCubit(gh<_i790.SignOutUseCase>()),
    );
    gh.factory<_i311.DashboardBloc>(
      () => _i311.DashboardBloc(gh<_i760.GetDashboardDataUseCase>()),
    );
    gh.factory<_i576.ForgotPasswordCubit>(
      () => _i576.ForgotPasswordCubit(gh<_i885.ForgotPasswordUseCase>()),
    );
    gh.factory<_i1033.DocumentsBloc>(
      () => _i1033.DocumentsBloc(gh<_i142.GetDocumentsUseCase>()),
    );
    gh.factory<_i276.ResetPasswordCubit>(
      () => _i276.ResetPasswordCubit(gh<_i760.ConfirmForgotPasswordUseCase>()),
    );
    gh.factory<_i229.GetPaymentsUseCase>(
      () => _i229.GetPaymentsUseCase(gh<_i733.PaymentsRepository>()),
    );
    gh.factory<_i42.GetProjectProgressUseCase>(
      () => _i42.GetProjectProgressUseCase(gh<_i209.UpdatesRepository>()),
    );
    gh.factory<_i88.ConfirmSignUpCubit>(
      () => _i88.ConfirmSignUpCubit(
        gh<_i76.ConfirmSignUpUseCase>(),
        gh<_i174.ResendSignUpCodeUseCase>(),
      ),
    );
    gh.factory<_i663.SupportBloc>(
      () => _i663.SupportBloc(gh<_i684.GetSupportTicketsUseCase>()),
    );
    gh.factory<_i705.SignInCubit>(
      () => _i705.SignInCubit(gh<_i128.SignInUseCase>()),
    );
    gh.factory<_i486.SplashCubit>(
      () => _i486.SplashCubit(gh<_i942.CheckAuthStatusUseCase>()),
    );
    gh.factory<_i852.SignUpCubit>(
      () => _i852.SignUpCubit(gh<_i163.SignUpUseCase>()),
    );
    gh.factory<_i257.PaymentBloc>(
      () => _i257.PaymentBloc(gh<_i229.GetPaymentsUseCase>()),
    );
    gh.factory<_i319.UpdatesBloc>(
      () => _i319.UpdatesBloc(gh<_i42.GetProjectProgressUseCase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i866.NetworkModule {}
