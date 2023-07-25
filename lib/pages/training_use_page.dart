import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runningam/widgets/training/training_interval_list_widget.dart';
import 'package:runningam/widgets/training/use_training_widget.dart';

import '../models/training_set.dart';

class TrainingUsePage extends StatelessWidget {
  TrainingSet training;

  TrainingUsePage({super.key, required this.training});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Training: ${training.name}'),
      ),
      body: Center(
              child:
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          UseTrainingWidget(training: training),
                          TrainingIntervalListWidget(intervalsInRightOrder: training.getIntervalsAsSortedList()),
                        ],
                      ),
                    ),
                  );
                },
              )
    )
    );

      //
  }
}
