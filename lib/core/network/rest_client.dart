import 'package:dio/dio.dart';
import 'package:temp_architecture_app_setup/core/network/enums/request_method.dart';
import 'package:temp_architecture_app_setup/core/network/interceptors/logging_interceptor.dart';
import 'package:temp_architecture_app_setup/core/constants/api_constants.dart';

/// Thin Dio wrapper. Each instance targets one [baseUrl].
class RestClient {
  late final Dio dio;

  RestClient({required String baseUrl}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout:
            const Duration(milliseconds: ApiConstants.connectTimeout),
        receiveTimeout:
            const Duration(milliseconds: ApiConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    )..interceptors.add(LoggingInterceptor());
  }
}

/// Typed request descriptor passed to [RestServiceBase.executeRequest].
class RestRequest {
  final String path;
  final dynamic body;
  final RequestMethod method;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? headers;
  final Duration? timeout;
  final CancelToken? cancelToken;

  const RestRequest(
    this.path, {
    this.body,
    this.method = RequestMethod.get,
    this.queryParameters,
    this.headers,
    this.timeout,
    this.cancelToken,
  });
}
