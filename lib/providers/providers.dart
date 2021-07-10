import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physiotherapy/application/notifiers/auth_sign_in_notifier.dart';
import 'package:physiotherapy/application/notifiers/store_user_data_notifier.dart';
import 'package:physiotherapy/authentication/auth_client.dart';
import 'package:physiotherapy/utils/database.dart';

final databaseProvider = Provider<Database>(
  (ref) => Database(),
);
final authenticationClientProvider = Provider<AuthenticationClient>(
  (ref) => AuthenticationClient(),
);
final authSignInNotifierProvider = StateNotifierProvider(
  (ref) => AuthSignInNotifier(ref.watch(authenticationClientProvider)),
);
final storeUserDataNotifierProvider = StateNotifierProvider(
  (ref) => StoreUserDataNotifier(ref.watch(databaseProvider)),
);
