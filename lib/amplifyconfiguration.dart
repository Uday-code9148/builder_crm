// Generated from AWS Cognito config.
// DO NOT commit real credentials — move to environment-specific config or
// fetch from a secure backend before shipping to production.
const amplifyconfig = r'''
{
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",
  "auth": {
    "plugins": {
      "awsCognitoAuthPlugin": {
        "UserAgent": "aws-amplify/cli",
        "Version": "0.1.0",
        "CognitoUserPool": {
          "Default": {
            "PoolId": "ap-south-1_Ei59iaDi8",
            "AppClientId": "2h1oq3i5fovrtcvs067neandt4",
            "Region": "ap-south-1"
          }
        },
        "Auth": {
          "Default": {
            "authenticationFlowType": "USER_SRP_AUTH"
          }
        }
      }
    }
  }
}
''';
