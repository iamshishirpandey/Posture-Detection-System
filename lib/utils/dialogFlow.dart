import 'dart:convert';
import 'dart:typed_data';

import 'package:dialog_flowtter/dialog_flowtter.dart' as df;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dialogflow {
  // static Future<String> takeVoiceInput() async {
  //   String recognizedVoiceInputString = '';

  //   if (isSpeechAvailable) {
  //     await speech.listen(
  //       // listenFor: Duration(minutes: 2),
  //       // pauseFor: Duration(seconds: 5),
  //       onResult: (result) {
  //         double confidence = result.confidence;

  //         if (confidence > 0.5) {
  //           result.recognizedWords;
  //           recognizedVoiceInputString = result.recognizedWords;
  //         }
  //       },
  //     );
  //   }
  // }

  static Future<df.DetectIntentResponse> initialize() async {
    final df.DialogFlowtter dialogFlowtter = await df.DialogFlowtter.fromFile(
      path: 'assets/dialogflow/physio_auth.json',
      sessionId: '101', // use the timestamp as the session id
    );

    final df.QueryInput queryInput = df.QueryInput(
      text: df.TextInput(
        text: 'Initialize the app',
        languageCode: 'en',
      ),
    );

    String rawJson =
        await rootBundle.loadString('assets/dialogflow/config.json');

    Map<String, dynamic> data = jsonDecode(rawJson);

    df.DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: queryInput,
      audioConfig: df.OutputAudioConfig(
        synthesizeSpeechConfig: df.SynthesizeSpeechConfig.fromJson(data),
      ),
    );

    return response;
  }

  static Future<void> poseCompletion({
    @required String poseName,
    @required String accuracy,
  }) async {
    final df.DialogFlowtter dialogFlowtter = await df.DialogFlowtter.fromFile(
      path: 'assets/dialogflow/physio_auth.json',
      sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    final df.QueryInput queryInput = df.QueryInput(
      text: df.TextInput(
        text: 'Completed $poseName pose, accuracy $accuracy',
        languageCode: 'en',
      ),
    );

    String rawJson =
        await rootBundle.loadString('assets/dialogflow/config.json');

    Map<String, dynamic> data = jsonDecode(rawJson);

    df.DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: queryInput,
      audioConfig: df.OutputAudioConfig(
        synthesizeSpeechConfig: df.SynthesizeSpeechConfig.fromJson(data),
      ),
    );
  }

  static Future<void> poseRecognition({
    @required Function(bool) onComplete,
  }) async {
    final df.DialogFlowtter dialogFlowtter = await df.DialogFlowtter.fromFile(
      path: 'assets/dialogflow/sofia_auth.json',
      sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    final df.QueryInput queryInput = df.QueryInput(
      text: df.TextInput(
        text: 'Recognize pose',
        languageCode: 'en',
      ),
    );

    String rawJson =
        await rootBundle.loadString('assets/dialogflow/config.json');

    Map<String, dynamic> data = jsonDecode(rawJson);

    df.DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: queryInput,
      audioConfig: df.OutputAudioConfig(
        synthesizeSpeechConfig: df.SynthesizeSpeechConfig.fromJson(data),
      ),
    );
  }

  static Future<void> bodyVisible() async {
    final df.DialogFlowtter dialogFlowtter = await df.DialogFlowtter.fromFile(
      path: 'assets/dialogflow/physio_auth.json',
      sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    final df.QueryInput queryInput = df.QueryInput(
      text: df.TextInput(
        text: 'Body visible camera',
        languageCode: 'en',
      ),
    );

    String rawJson =
        await rootBundle.loadString('assets/dialogflow/config.json');

    Map<String, dynamic> data = jsonDecode(rawJson);

    df.DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: queryInput,
      audioConfig: df.OutputAudioConfig(
        synthesizeSpeechConfig: df.SynthesizeSpeechConfig.fromJson(data),
      ),
    );

    Uint8List audioBytes = response.outputAudioBytes;
  }

  static Future<df.DetectIntentResponse> getDialogflowResponse({
    @required String questionString,
  }) async {
    final df.DialogFlowtter dialogFlowtter = await df.DialogFlowtter.fromFile(
      path: 'assets/dialogflow/physio_auth.json',
      sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    final df.QueryInput queryInput = df.QueryInput(
      text: df.TextInput(
        text: questionString,
        languageCode: 'en',
      ),
    );

    String rawJson =
        await rootBundle.loadString('assets/dialogflow/config.json');

    Map<String, dynamic> data = jsonDecode(rawJson);

    df.DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: queryInput,
      audioConfig: df.OutputAudioConfig(
        synthesizeSpeechConfig: df.SynthesizeSpeechConfig.fromJson(data),
      ),
    );

    return response;
  }
}
