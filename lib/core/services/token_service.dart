import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:injectable/injectable.dart';

/// Handles Cognito token lifecycle for the REST layer.
///
/// Amplify secures tokens internally (Keychain / Keystore) — no local caching needed.
///  - [getAccessToken] : returns the current token, Amplify auto-refreshes if near expiry
///  - [refreshToken]   : forces a new access token from Cognito, called on every 401
@singleton
class TokenService {
  const TokenService();

  /// Returns the current access token. Amplify refreshes it automatically when expired.
  Future<String?> getAccessToken() => _fetch(forceRefresh: false);

  /// Forces Cognito to issue a new access token via the refresh token.
  /// Called automatically by [RestServiceBase] on every 401.
  Future<String?> refreshToken() => _fetch(forceRefresh: true);

  Future<String?> _fetch({required bool forceRefresh}) async {
    try {
      final session = await Amplify.Auth.fetchAuthSession(
        options: FetchAuthSessionOptions(forceRefresh: forceRefresh),
      ) as CognitoAuthSession;
      return session.userPoolTokensResult.valueOrNull?.accessToken.raw;
    } catch (_) {
      return null;
    }
  }
}
