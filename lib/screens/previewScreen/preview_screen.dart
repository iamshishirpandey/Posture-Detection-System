import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:physiotherapy/models/pose.dart';
import 'package:physiotherapy/screens/preview_screen/camera_preview_widget.dart';
import 'package:physiotherapy/screens/preview_screen/rotate_to_landspace_widget.dart';
import 'package:physiotherapy/screens/recognizer/recognizer_screen.dart';
import 'package:physiotherapy/utils/dialogFlow.dart';
import 'package:physiotherapy/widgets/overlays/timer_overlay.dart';
import 'package:physiotherapy/widgets/video_manager.dart';
import 'package:tflite/tflite.dart';
import 'package:wakelock/wakelock.dart';

import '../../main.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class PreviewScreen extends StatefulWidget {
  final Pose pose;

  const PreviewScreen({
    Key key,
    @required this.pose,
  }) : super(key: key);

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  CameraController _cameraController;

  List<dynamic> _recognitions;

  bool _isBodyVisible = false;
  bool isDetecting = false;
  bool isInLandscape = false;

  int totalPartsInFrame = 0;
  int totalNumOfTimesPositive = 0;

  setRecognitions(recognitions, imageHeight, imageWidth) async {
    totalPartsInFrame = 0;
    _isBodyVisible = false;
    if (mounted) {
      setState(() {
        _recognitions = recognitions;
      });

      if (_recognitions.isNotEmpty) {
        Map<dynamic, dynamic> partsMap = _recognitions[0]['keypoints'];
        partsMap.forEach((key, value) {
          double score = value['score'];

          if (score > 0.5) {
            totalPartsInFrame++;
          }
        });

        print('TOTAL PARTS: $totalPartsInFrame');

        if (totalPartsInFrame > 11) {
          setState(() {
            _isBodyVisible = true;
            totalNumOfTimesPositive++;
          });
        } else {
          setState(() {
            totalNumOfTimesPositive = 0;
          });
        }

        if (totalNumOfTimesPositive > 5) {
          _cameraController?.stopImageStream();
          print('READY');
          await Navigator.of(context)
              .push(
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (context, _, __) => TimerOverlay(
                    pose: widget.pose,
                  ),
                ),
              )
              .whenComplete(
                () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => RecognizerScreen(
                      pose: widget.pose,
                      cameraController: _cameraController,
                    ),
                  ),
                ),
              );
        }
      }
    }
  }

  Future<void> initializeCameraController() async {
    await Tflite.loadModel(
      model: "assets/tflite/posenet.tflite",
      numThreads: 4,
    );

    _cameraController = CameraController(cameras[1], ResolutionPreset.low);
    _cameraController.initialize().then((_) async {
      if (!mounted) {
        return;
      }

      _cameraController.startImageStream((CameraImage image) {
        if (!isDetecting &&
            isInLandscape &&
            _cameraController.value.isStreamingImages) {
          isDetecting = true;

          Tflite.runPoseNetOnFrame(
            bytesList: image.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            imageHeight: image.height,
            imageWidth: image.width,
            asynch: true,
            rotation: 180,
            numResults: 1,
            threshold: 0.2,
          ).then(
            (recognitions) {
              setRecognitions(
                recognitions,
                image.height,
                image.width,
              );
              isDetecting = false;
            },
          );
        }
      });
    });
  }

  fixInLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isInLandscape = true;
      });
    });
  }

  @override
  void initState() {
    // _videoController = _videoController..play();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    Wakelock.enable();

    initializeCameraController();
    VideoManager.initializeVideoController(videoUrl: widget.pose.videoUrl);

    Dialogflow.bodyVisible();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    return WillPopScope(
      onWillPop: () async {
        // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
        // SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.portraitUp,
        //   DeviceOrientation.portraitDown,
        // ]);

        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return RotateToLandscapeWidget();
            } else {
              fixInLandscape();

              if (_cameraController != null) {
                if (_cameraController.value.isInitialized) {
                  return Stack(
                    children: [
                      CameraPreviewWidget(
                        isBodyVisible: _isBodyVisible,
                        cameraController: _cameraController,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            bottom: 8.0,
                          ),
                          child: Image.asset(
                            'assets/images/human_outline.png',
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    color: Colors.white,
                  );
                }
              } else {
                return Container(
                  color: Colors.white,
                );
              }
            }
          },
        ),
      ),
    );
  }
}
