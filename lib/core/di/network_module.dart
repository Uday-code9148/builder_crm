import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/constants/api_constants.dart';
import 'package:temp_architecture_app_setup/core/network/rest_client.dart';

@module
abstract class NetworkModule {
  @singleton
  RestClient get restClient => RestClient(baseUrl: ApiConstants.baseUrl);
}
