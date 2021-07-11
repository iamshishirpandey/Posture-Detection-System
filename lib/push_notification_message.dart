import 'package:flutter/material.dart';

class PushNotificationMessage {
  final String title;
  final String body;
  final String sound;
  PushNotificationMessage({
    @required this.title,
    @required this.body,
    @required this.sound,
  });
}
