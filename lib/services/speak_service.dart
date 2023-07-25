import 'dart:async';
import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';

class SpeakService {

  static final SpeakService __instance = SpeakService._internal();
  factory SpeakService() => __instance;

  final FlutterTts __flutterTts = FlutterTts();

  SpeakService._internal()  {
    if(Platform.isIOS){
      __flutterTts.setSharedInstance(true);
      __flutterTts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.ambient,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers
          ],
          IosTextToSpeechAudioMode.voicePrompt);
    }
  }

  Future<void> speak (String text) async{
    Completer<void> onFinish = Completer();
    __flutterTts.completionHandler = () => onFinish.complete();
    __flutterTts.speak(text);
    return onFinish.future;
  }

  Future<void> speakAwait (String text) async{
    return await speak(text);
  }

}