import 'package:dio/dio.dart';
import 'package:temp_architecture_app_setup/core/error/exceptions.dart';
import 'package:temp_architecture_app_setup/core/extensions/object_extension.dart';
import 'package:temp_architecture_app_setup/core/network/enums/request_method.dart';
import 'package:temp_architecture_app_setup/core/network/rest_client.dart';
import 'package:temp_architecture_app_setup/core/services/token_service.dart';

/// Base class for all remote data-source services.
///
/// Handles:
/// - Auth token injection per request (reads directly from Amplify via [TokenService])
/// - Automatic retry (up to [_maxRetries]) on 401 via [TokenService.refreshToken]
/// - Unified error mapping to typed exceptions
/// - Request factory helpers: [get], [post], [put], [delete]
abstract class RestServiceBase {
  static const int _maxRetries = 3;
  static final List<CancelToken> _activeTokens = [];

  final RestClient _client;
  final TokenService _tokenService;

  RestServiceBase(this._client, this._tokenService);

  // ─── Hooks (override in subclass if needed) ────────────────────────────────

  /// Called when all token refresh retries are exhausted. Override to navigate to login, etc.
  void onUnauthorized() {}

  // ─── Core execution ────────────────────────────────────────────────────────

  Future<T> executeRequest<T>(RestRequest request, T Function(Map<String, dynamic>) fromJson, {int retryCount = 0}) async {
    if (request.cancelToken != null) {
      _activeTokens.add(request.cancelToken!);
    }

    try {
      final response = await _send(await _withAuthHeader(request));
      _assertSuccess(response);

      final data = response.data;
      if (data is T) return data;
      if (data is Map<String, dynamic>) return fromJson(data);
      throw ArgumentError('Unexpected response type: ${data.runtimeType}');
    } on DioException catch (e, s) {
      e.logException(s);
      if (e.response?.statusCode == 401 && retryCount < _maxRetries) {
        return _retryAfterRefresh(request, fromJson, retryCount + 1);
      }
      _throwMapped(e);
    } catch (e, s) {
      e.logException(s);
      rethrow;
    } finally {
      if (request.cancelToken != null) {
        _activeTokens.remove(request.cancelToken);
      }
    }
  }

  // ─── Private helpers ───────────────────────────────────────────────────────

  Future<RestRequest> _withAuthHeader(RestRequest req) async {
    final token = await _tokenService.getAccessToken();
    if (token == null) return req;
    return RestRequest(
      req.path,
      body: req.body,
      method: req.method,
      queryParameters: req.queryParameters,
      headers: {...?req.headers, 'Authorization': 'Bearer $token'},
      timeout: req.timeout,
      cancelToken: req.cancelToken,
    );
  }

  Future<Response<dynamic>> _send(RestRequest req) => _client.dio.request<dynamic>(
    req.path,
    data: req.body,
    queryParameters: req.queryParameters,
    cancelToken: req.cancelToken,
    options: Options(method: _methodStr(req.method), headers: req.headers, receiveTimeout: req.timeout ?? const Duration(seconds: 60)),
  );

  void _assertSuccess(Response<dynamic> r) {
    final code = r.statusCode;
    if (code == null) throw ServerException(message: 'No status code');
    if (code == 200 || code == 201) return;
    if (code == 204) throw ServerException(message: 'No content');
    if (code == 401) throw UnauthorizedException();
    if (code == 403) throw UnauthorizedException(message: 'Forbidden');
    if (code == 404) throw ServerException(message: 'Resource not found');
    if (code >= 500) throw ServerException(message: 'Server error');
  }

  Never _throwMapped(DioException e) {
    final code = e.response?.statusCode;
    final msg = e.response?.data?['messages']?[0] as String? ?? e.message;
    if (code == null) throw NetworkException();
    if (code == 401) throw UnauthorizedException();
    if (code == 403) throw UnauthorizedException(message: 'Forbidden');
    if (code == 404) throw ServerException(message: msg ?? 'Not found');
    if (code >= 500) throw ServerException(message: msg ?? 'Server error');
    throw ServerException(message: msg ?? 'Unknown error');
  }

  Future<T> _retryAfterRefresh<T>(RestRequest req, T Function(Map<String, dynamic>) fromJson, int retryCount) async {
    final token = await _tokenService.refreshToken();
    if (token == null) {
      onUnauthorized();
      throw UnauthorizedException(message: 'Token refresh failed');
    }
    return executeRequest(req, fromJson, retryCount: retryCount);
  }

  String _methodStr(RequestMethod m) => switch (m) {
    RequestMethod.get => 'GET',
    RequestMethod.post => 'POST',
    RequestMethod.put => 'PUT',
    RequestMethod.patch => 'PATCH',
    RequestMethod.delete => 'DELETE',
  };

  // ─── Request factory helpers ───────────────────────────────────────────────

  RestRequest get(String path, {Map<String, dynamic>? query, CancelToken? cancelToken}) => RestRequest(path, method: RequestMethod.get, queryParameters: query, cancelToken: cancelToken);

  RestRequest post(String path, {dynamic body, Map<String, dynamic>? query, CancelToken? cancelToken}) => RestRequest(path, body: body, method: RequestMethod.post, queryParameters: query, cancelToken: cancelToken);

  RestRequest put(String path, {dynamic body, Map<String, dynamic>? query, CancelToken? cancelToken}) => RestRequest(path, body: body, method: RequestMethod.put, queryParameters: query, cancelToken: cancelToken);

  RestRequest delete(String path, {dynamic body, Map<String, dynamic>? query, CancelToken? cancelToken}) => RestRequest(path, body: body, method: RequestMethod.delete, queryParameters: query, cancelToken: cancelToken);

  /// Cancels all in-flight requests — call on sign-out.
  static void cancelAll([String reason = 'Cancelled']) {
    for (final t in _activeTokens) {
      if (!t.isCancelled) t.cancel(reason);
    }
    _activeTokens.clear();
  }
}
