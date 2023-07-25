import 'dart:async';
import 'package:flutter/material.dart';
import 'package:runningam/models/training_set.dart';
import 'package:runningam/services/speak_service.dart';
import 'package:runningam/services/training_background_service.dart';

class UseTrainingWidget extends StatefulWidget {
  TrainingSet training;

  UseTrainingWidget({super.key, required this.training});

  @override
  State<StatefulWidget> createState() {
    return UseTrainingWidgetState(training: training);
  }
}

class UseTrainingWidgetState extends State<StatefulWidget> {
  Duration duration = const Duration(seconds: 1);
  DateTime? pausedAt;
  Duration pausedFor = const Duration(seconds: 0);
  DateTime? start;
  SpeakService speakService = SpeakService();
  final TrainingBackgroundService __trainingBackgroundService = TrainingBackgroundService();

  late Timer timer;
  TrainingSet training;

  UseTrainingWidgetState({required this.training});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Padding(
            padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              minimumSize: Size(
                  viewportConstraints.maxWidth * 0.75,
                  viewportConstraints.maxWidth * 0.75
              ),
            ),
            onPressed: startTraining,
            child: LayoutBuilder(builder: (context, constraint) {
              return Icon(
                  Icons.play_arrow,
                  size:
                  viewportConstraints.maxWidth * 0.65);
            }),
          ),
        );
      },
    );
  }

  startTraining() {
    DateTime now = DateTime.now();
    start = now;
    speakService.speak('Start ${training.name}');
    __trainingBackgroundService.start(training);

  }
}
