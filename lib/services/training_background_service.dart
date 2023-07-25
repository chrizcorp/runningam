import 'dart:async';

import 'package:messaging/messaging.dart';
import 'package:runningam/models/Interval.dart';
import 'package:runningam/models/training_set.dart';
import 'package:runningam/services/message/messaging-factory.dart';
import 'package:runningam/services/speak_service.dart';
import 'package:runningam/services/message/currentTraining/training_current_interval_message.dart';
import 'package:runningam/services/training/training_interval_handler.dart';

class TrainingBackgroundService {

  final SpeakService speakService = SpeakService();

  static final TrainingBackgroundService _instance = TrainingBackgroundService._internal();
  factory TrainingBackgroundService() => _instance;

  TrainingBackgroundService._internal();


  final Messaging __messaging = MessagingFactory().messaging;
  TrainingSet? __actualTraining;
  int __currentInterval = 0;
  TrainingIntervalHandler? __intervalHandler;
  int countdown = 3;
  int actualCountdown = 3;
  late List<IntervalUnitDTO> __intervals;
  late Timer timer;

  start(TrainingSet set){
    if(__actualTraining != null){
      throw StateError('Training ${__actualTraining?.name} is still active you have to abort or finish it to start a new one.');
    }

    __actualTraining = set;
    __intervals = set.getIntervalsAsSortedList();

    begin();
  }

  begin(){
    if(__actualTraining == null){
      throw StateError('No training is active you have to start a new one.');
    }else{
      __begin(__actualTraining!);
    }
  }

  __begin(TrainingSet set){

    speakService
        .speak('Start ${set.name}')
        .then((value) {
          __currentInterval = 0;
          actualCountdown = countdown;
          timer = Timer.periodic(
              const Duration(seconds: 1),
              (Timer timer) => __handle(set)
          );
      });

  }

  Future<void> __handle(TrainingSet set) async{

    if(__currentInterval >= __intervals.length){
      speakService.speak('Congratulations you completed the training.');
      timer.cancel();
      __actualTraining = null;
      return;
    }

    if(__intervalHandler == null){
      IntervalUnitDTO currentInterval = __intervals.elementAt(__currentInterval);

      __intervalHandler ??= TrainingIntervalHandler(
          interval: currentInterval
      );

      __messaging.publish(CurrentIntervalMessage(interval: currentInterval));
    }


    bool isFinished = await __intervalHandler!.handle();

    if(isFinished){
      __intervalHandler = null;
      __currentInterval++;
    }
  }



}