import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physiotherapy/application/notifiers/auth_sign_in_notifier.dart';
import 'package:physiotherapy/authentication/auth_client.dart';

final authenticationClientProvider = Provider<AuthenticationClient>(
  (ref) => AuthenticationClient(),
);
final authSignInNotifierProvider = StateNotifierProvider(
  (ref) => AuthSignInNotifier(ref.watch(authenticationClientProvider)),
);
