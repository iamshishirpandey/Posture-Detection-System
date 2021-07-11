import 'package:camera/camera.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:physiotherapy/utils/routes/onGeneratedRoutes.dart';
import 'package:physiotherapy/utils/routes/routeConstants.dart';

import 'push_notification_service.dart';

/// The list of camera types (mainly including: front and back)
List<CameraDescription> cameras = [];
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  try {
    // To load the cameras before the app is initialized
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: ${e.code}\nError Message: ${e.description}');
  }
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    final pushNotificationService =
        PushNotificationService(_firebaseMessaging, context, navigatorKey);
    pushNotificationService.initialise();

    return MaterialApp(
      title: 'Physio Therapy App',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: RouteConstants.LOGIN,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
