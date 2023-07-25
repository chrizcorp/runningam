
import 'dart:async';

import 'package:runningam/models/Interval.dart';
import 'package:runningam/services/speak_service.dart';

import '../interval_service.dart';

class TrainingIntervalHandler {
  final SpeakService speakService = SpeakService();

  late int __actualCountdown;
  final int countdown;
  DateTime? __currentIntervalStart;
  late IntervalUnitDTO __interval;

  TrainingIntervalHandler({
    required IntervalUnitDTO interval,
    this.countdown = 3
  }){
    __interval = interval;
    __actualCountdown = countdown +1;
  }

  announce(){
    String durationString = IntervalService.getInitialDurationString(__interval);
    speakService.speakAwait('Start with ${__interval.name} for $durationString ');
    __actualCountdown--;
  }


  __countdown(){
      print('Countdown: $__actualCountdown');
      speakService.speak(__actualCountdown.toString());
      __actualCountdown--;
  }

  Future<bool> handle() async{
    bool neededPreTask = __handlePreTasks();
    if(neededPreTask){
      return false;
    }

    DateTime now = DateTime.now();
    __currentIntervalStart ??= now;

    Duration duration = now.difference(__currentIntervalStart!);
    int durationInSeconds = duration.inSeconds;

    return __handleInterval(durationInSeconds);
  }

  /// return true if a pretask is executed other wise it will return false.
  bool __handlePreTasks(){

    if(__actualCountdown > countdown){
      announce();
      return true;
    }

    if(__actualCountdown > 0){
      __countdown();
      return true;
    }

   return false;
  }


  Future<bool> __handleInterval(int durationInSec) async{
    int intervalDuration = IntervalService.getDurationInSeconds(__interval);

    if(durationInSec >= intervalDuration){
      return true;
    }

    String durationString = IntervalService.getDurationStringsForSeconds(durationInSec);

    if(durationInSec == 0) {
    }else if(durationInSec %60 == 0 ){

      await speakService.speak('You\'re $durationString in ${__interval.name}');
    }

    print('Interval ${__interval.name} for $durationString');

    return false;
  }
}