import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physiotherapy/application/states/store_user_data_state.dart';
import 'package:physiotherapy/models/user.dart';
import 'package:physiotherapy/utils/database.dart';

class StoreUserDataNotifier extends StateNotifier<StoreUserDataState> {
  final Database _database;

  StoreUserDataNotifier(this._database) : super(StoreUserDataState());

  Future<void> storeData({
    @required String uid,
    @required String imageUrl,
    @required String userName,
  }) async {
    try {
      state = StoreUserDataState.storing();
      User userData = await _database.storeUserData(
        uid: uid,
        imageUrl: imageUrl,
        userName: userName,
      );
      print('USER DATA: $userData');
      state = StoreUserDataState.stored(userData);
    } catch (error) {
      state = StoreUserDataState.error(message: 'Error storing user data');
    }
    return;
  }
}
