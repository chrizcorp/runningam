import 'package:flutter/material.dart';
import 'package:runningam/pages/training_set_edit_page.dart';
import 'package:runningam/repository/training_set_repository.dart';

import '../models/training_set.dart';
import '../models/training_set_list.dart';
import '../widgets/trainingset/training_set_overview_widget.dart';

class TrainingSetOverviewPage extends StatefulWidget {
  const TrainingSetOverviewPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return TrainingSetOverviewPageState();
  }
}

class TrainingSetOverviewPageState extends State<TrainingSetOverviewPage> {
  final String __title = 'Select Training Set';
  final TrainingSetRepository __repository = TrainingSetRepository();
  ValueNotifier<int> needRefresh = ValueNotifier(0);

  TrainingSetList trainingSetList = TrainingSetList();

  TrainingSetOverviewPageState() {
    needRefresh.addListener(() {
      setState(() {
        updateSetList();
      });
    });

    updateSetList();
  }

  List<TrainingSet> fetchSets() {
    return __repository.getAll();
  }

  updateSetList() {
    trainingSetList.set(fetchSets());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(__title),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrainingIntervalEditPage(
                              trainingSet: TrainingSet()
                          ))
              ).then((value) {
                    setState(() {
                      updateSetList();
                    });
                  }),
              child: const Text('Add Trainingsset')),
          TrainingSetOverviewWidget(
              trainingSetList: trainingSetList,
              needRefresh: needRefresh),
        ],
      )),
    );
  }
}
