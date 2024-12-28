import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AmplifyAuth {
  // SIGNUP
  Future<SignUpResult?> signUpUser({
    required String username,
    required String password,
    required Map<AuthUserAttributeKey, String> userAttributes, // Dynamic attributes
  }) async {
    try {
      return await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: SignUpOptions(userAttributes: userAttributes),
      );
    } on AuthException catch (e) {
      throw Exception('Error signing up user: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<ResetPasswordResult> resetPassword(String username) async {
    try {
      return await Amplify.Auth.resetPassword(
        username: username,
      );
    } on AuthException catch (e) {
      throw Exception('Error resetting password: ${e.message}');
    }
  }

  Future<ResetPasswordResult> confirmResetPassword({
    required String username,
    required String newPassword,
    required String confirmationCode,
  }) async {
    try {
      return await Amplify.Auth.confirmResetPassword(
        username: username,
        newPassword: newPassword,
        confirmationCode: confirmationCode,
      );
    } on AuthException catch (e) {
      throw Exception('Error resetting password: ${e.message}');
    }
  }

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await Amplify.Auth.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
    } on AuthException catch (e) {
      throw Exception('Error updating password: ${e.message}');
    }
  }

  Future<SignInResult> confirmSignIn(String code) async {
    try {
      return await Amplify.Auth.confirmSignIn(confirmationValue: code);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<bool> fetchAuthSession() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession();
      return result.isSignedIn;
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<CognitoAuthSession> fetchCognitoAuthSession() async {
    try {
      final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      return await cognitoPlugin.fetchAuthSession();
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }
}