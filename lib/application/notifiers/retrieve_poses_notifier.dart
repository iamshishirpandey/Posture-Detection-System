import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physiotherapy/application/states/retrieve_poses_state.dart';
import 'package:physiotherapy/models/pose.dart';
import 'package:physiotherapy/utils/database.dart';

class RetrievePosesNotifier extends StateNotifier<RetrievePosesState> {
  final Database _database;

  RetrievePosesNotifier(
    this._database,
  ) : super(RetrievePosesState());

  Future<void> retrievePoses() async {
    try {
      state = RetrievePosesState.retrieving();
      List<Pose> poses = await _database.retrievePoses();
      state = RetrievePosesState.retrieved(poses);
    } catch (error) {
      state = RetrievePosesState.error(message: 'Error retrieving poses');
    }
  }
}
