import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoManager {
  static VideoPlayerController videoController;

  static Future<void> initializeVideoController({
    @required String videoUrl,
  }) async {
    videoController = VideoPlayerController.network(videoUrl);
    await videoController.initialize();
  }
}
