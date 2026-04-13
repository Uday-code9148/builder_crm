import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/amplifyconfiguration.dart';

@singleton
class AmplifyService {
  Future<void> configure() async {
    if (Amplify.isConfigured) return;
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      // Safe to ignore — happens on hot reload
    }
  }
}
