import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physiotherapy/application/notifiers/auth_sign_in_notifier.dart';
import 'package:physiotherapy/application/notifiers/retrieve_poses_notifier.dart';
import 'package:physiotherapy/application/notifiers/retrieve_user_notifier.dart';
import 'package:physiotherapy/application/notifiers/store_user_data_notifier.dart';
import 'package:physiotherapy/application/notifiers/store_user_score_notifier.dart';
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

final retrievePosesNotifierProvider = StateNotifierProvider(
  (ref) => RetrievePosesNotifier(ref.watch(databaseProvider)),
);
final storeUserScoreNotifierProvider = StateNotifierProvider(
  (ref) => StoreUserScoreNotifier(ref.watch(databaseProvider)),
);
final retrieveUserNotifierProvider = StateNotifierProvider(
  (ref) => RetrieveUserNotifier(ref.watch(databaseProvider)),
);
