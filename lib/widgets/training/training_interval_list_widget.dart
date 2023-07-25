import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging/messaging.dart';
import 'package:runningam/models/Interval.dart';
import 'package:runningam/services/interval_service.dart';
import 'package:runningam/services/message/currentTraining/training_current_interval_subscriber.dart';
import 'package:runningam/services/message/messaging-factory.dart';

class TrainingIntervalListWidget extends StatefulWidget{

  List<IntervalUnitDTO> intervalsInRightOrder;
  TrainingIntervalListWidget({super.key,
    required this.intervalsInRightOrder,
  });

  @override
  State<StatefulWidget> createState() {
    return TrainingIntervalListWidgetState(intervalsInRightOrder: intervalsInRightOrder);
  }

}

class TrainingIntervalListWidgetState extends State<TrainingIntervalListWidget> {

  late CurrentIntervalSubscriber subscriber;
  final List<IntervalUnitDTO> intervalsInRightOrder;
  List<Widget> children = [];
  final Messaging __messaging = MessagingFactory().messaging;
  DateTime __currentIntervalStart = DateTime.fromMicrosecondsSinceEpoch(0);
  Timer? timer;


  TrainingIntervalListWidgetState({
    required this.intervalsInRightOrder,
  }){
    subscriber = CurrentIntervalSubscriber(
        onInterval: (interval) => __startInterval(interval)
    );
    __messaging.subscribe(subscriber, to: subscriber.type);

    __buildChildren(null);
  }

  __startInterval(IntervalUnitDTO interval){
    __currentIntervalStart = DateTime.now().add(const Duration(seconds: 3));
    timer?.cancel();
    timer = Timer.periodic(
        const Duration(seconds: 1),
            (Timer timer) =>
                setState(() {
                  __buildChildren(interval);
                })
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ListBody(
                  children: children,
                )
              ],
            ),
        );
      },
    );
  }

  __buildChildren(IntervalUnitDTO? currentInterval){
    int currentIndex = currentInterval != null?  intervalsInRightOrder.indexOf(currentInterval) : -0;
    children = intervalsInRightOrder.indexed.map((pair) {
      int index = pair.$1;
      IntervalUnitDTO interval = pair.$2;

      if(index < currentIndex){
        return __buildPastChildren(interval);
      }else if(index == currentIndex){
        return __buildActiveChildren(interval);
      }else{
        return __buildFutureChildren(interval);
      }
    }).toList();
  }

  Widget __buildPastChildren(IntervalUnitDTO interval){
    return ListTile(
        enabled: false,
        title: Text(interval.name),
        trailing: Text(interval.durationToClockString()),
      );
  }

  Widget __buildActiveChildren(IntervalUnitDTO interval){
    double currentPercentage = __getCurrentPercentage(interval);
    if(currentPercentage <= 0){
      currentPercentage = 0;
    }

    print('Current percent $currentPercentage');


    return  Card(
        color: const Color.fromARGB(0, 255, 255, 255),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: const [
                    Colors.green,
                    Colors.white,
                  ],
                  stops: [
                    currentPercentage,
                    currentPercentage + 0.01
                  ]
              )
          ),
          child: ListTile(
          title: Text(interval.name),
          trailing: Text(interval.durationToClockString()),
        ),
      ),
    );
  }

  Widget __buildFutureChildren(IntervalUnitDTO interval){
    return ListTile(
      title: Text(interval.name),
      trailing: Text(interval.durationToClockString()),
    );
  }


  double __getCurrentPercentage(IntervalUnitDTO intervalUnitDTO){
    int currentDuration = DateTime.now().difference(__currentIntervalStart).inSeconds;
    int intervalDuration = IntervalService.getDurationInSeconds(intervalUnitDTO);
    return currentDuration / intervalDuration;
  }


}