import 'package:flutter/material.dart';
import 'package:runningam/models/Interval.dart';
import 'package:runningam/models/interval_unit_list.dart';
import 'package:runningam/models/training_interval.dart';
import 'package:runningam/models/training_set.dart';
import 'package:runningam/pages/interval_select_page.dart';
import 'package:runningam/repository/training_set_repository.dart';
import 'package:runningam/widgets/interval/interval_order_list_widget.dart';


class TrainingIntervalEditPage extends StatefulWidget {
  TrainingSet trainingSet;
  Function(TrainingSet)? onSave;

  TrainingIntervalEditPage({super.key, this.onSave, required this.trainingSet});

  @override
  State<StatefulWidget> createState() {
    return TrainingIntervalEditPageState(
        trainingSet: trainingSet,
        onSave: this.onSave
    );
  }
}

class TrainingIntervalEditPageState extends State<TrainingIntervalEditPage> {
  Function(TrainingSet)? onSave;

  String defaultNam = 'My Awesome Trainingsset from ${DateTime.now()}';
  String name = '';
  TrainingSet trainingSet;
  Map<int, IntervalUnitDTO> intervalsByPosition = {};
  TrainingSetRepository repository = TrainingSetRepository();
  late int id;
  late IntervalUnitOrderedList onIntervalsChangedExternally;
  late IntervalUnitOrderedList onChange = IntervalUnitOrderedList();

  TextEditingController nameController = TextEditingController();
  late IntervalOrderListWidget orderListWidget;
  late TextField nameField = TextField(
    controller: nameController,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: 'Name',
      hintText: defaultNam,
    ),
    autofocus: true,
    maxLength: 128,
    onChanged: (value) {
      setState(() {
        name = nameController.text;
      });
    },
  );

  TrainingIntervalEditPageState({this.onSave, required this.trainingSet}) {
    id = trainingSet.id;
    name = trainingSet.name;
    nameController.text = name;
    __updateIntervalsByPosition(trainingSet.intervals.nonNulls
        .toList()
        .asMap()
        .map((index, trainingInterval) => MapEntry(
        trainingInterval.position, trainingInterval.interval.target!)));
  }

  @override
  Widget build(BuildContext context) {
    IntervalOrderListWidget orderListWidget = IntervalOrderListWidget(
            intervals: onChange
    );

    onIntervalsChangedExternally = orderListWidget.onIntervalListUpdate;
    onIntervalsChangedExternally.addListener(() {
      setState(() {
        intervalsByPosition = onIntervalsChangedExternally.values;
        saveAll();
      });
    });


    return Scaffold(
      appBar: AppBar(
        title: Text(name.isNotEmpty ? 'Edit $name' : 'Add Trainingset'),
      ),
      body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            nameField,
                            ElevatedButton(
                                onPressed: () => openAdd(context),
                                child: const Text('Add Interval'))
                          ],
                        ),
                        orderListWidget,
                        ElevatedButton(
                            onPressed: () => {
                              saveAll(),
                              Navigator.pop(context, true)
                            },
                            child: const Text('save'))
                      ]));
            }),
    );
  }

  openAdd(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => IntervalSelectPage(
                exceptions: trainingSet.intervals.nonNulls
                    .map((e) => e.interval.target)
                    .nonNulls))
    ).then((object) {
      if (object is IntervalUnitDTO) {
        int position = intervalsByPosition.length;
        setState(() {
          intervalsByPosition[position] = object;
          saveAll();
        });
      }
    });
  }

  TrainingSet saveChange() {
    TrainingSet dto = TrainingSet(
        id: trainingSet.id,
        intervalsByPosition: intervalsByPosition,
        name: name.isNotEmpty ? name : defaultNam);

    return repository.save(dto);
  }

  __updateIntervalsByPosition(Map<int,IntervalUnitDTO> update){
    intervalsByPosition= update;
    onChange.set(intervalsByPosition);
  }

  saveAll() {
    TrainingSet saved = saveChange();
    id = saved.id;
    name = saved.name;
    __updateIntervalsByPosition(
        saved
            .intervals
            .nonNulls
            .toList()
            .asMap()
            .map(
                (ignored, trainingInterval) => MapEntry(
                    trainingInterval.position,
                    trainingInterval.interval.target!
                ))
    );
    if (onSave != null) {
      onSave!(saved);
    }
  }
}
