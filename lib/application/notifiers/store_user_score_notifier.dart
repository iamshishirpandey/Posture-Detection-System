import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physiotherapy/application/states/store_user_score_state.dart';
import 'package:physiotherapy/utils/database.dart';

class StoreUserScoreNotifier extends StateNotifier<StoreUserScoreState> {
  final Database _database;

  StoreUserScoreNotifier(this._database) : super(StoreUserScoreState());

  Future<void> storeScore({
    @required String poseName,
    @required int stars,
    @required double accuracy,
    @required int timeInMilliseconds,
  }) async {
    try {
      state = StoreUserScoreState.storing();
      await _database.uploadScore(
        poseName: poseName,
        stars: stars,
        accuracy: accuracy,
        timeInMilliseconds: timeInMilliseconds,
      );
      state = StoreUserScoreState.stored();
    } catch (error) {
      print(error);
      state = StoreUserScoreState.error(message: 'Error storing user score');
    }
  }
}
