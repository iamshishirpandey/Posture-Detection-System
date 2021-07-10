import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physiotherapy/application/states/auth_sign_in_state.dart';
import 'package:physiotherapy/authentication/auth_client.dart';
import 'package:physiotherapy/main.dart';

class AuthSignInNotifier extends StateNotifier<AuthSignInState> {
  final AuthenticationClient _authentication;

  AuthSignInNotifier(this._authentication) : super(AuthSignInState());

  Future<void> googleSignIn(context) async {
    try {
      state = AuthSignInState.signingIn();
      final signedInUser = await _authentication.signInWithGoogle(context);
      state = AuthSignInState.signedIn(signedInUser);
    } catch (error) {
      state = AuthSignInState.error(
          message: 'Error signing in, please check your network connection');
    }
  }
}
