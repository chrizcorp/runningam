import 'package:flutter/material.dart';
import 'package:runningam/repository/interval_repository.dart';
import 'package:runningam/widgets/number_picker_widget.dart';

import '../../models/Interval.dart';

class IntervalPlanerWidget extends StatefulWidget {
  IntervalUnitDTO interval;
  Function(IntervalUnitDTO interval)? onSave;
  
  
  IntervalPlanerWidget({
    super.key,
    required this.interval,
    this.onSave
  });

  @override
  IntervalPlanerWidgetState createState() {
    return IntervalPlanerWidgetState(givenInterval: interval, onSave: onSave);
  }
}

class IntervalPlanerWidgetState extends State<IntervalPlanerWidget> {
  IntervalRepository repository = IntervalRepository();

  IntervalUnitDTO givenInterval;
  TextEditingController nameController = TextEditingController();
  ValueNotifier<int> onMinuteChanged = ValueNotifier(0);
  ValueNotifier<int> onSecondChanged = ValueNotifier(0);
  String __name = '';
  Function(IntervalUnitDTO interval)? onSave;

  late TextField nameField = TextField(
    controller: nameController,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Name',
    ),
    maxLength: 128,
    onChanged: (value) {
      setState(() {
        __name = nameController.text;
      });
    },
  );

  IntervalPlanerWidgetState({
    required this.givenInterval,
    this.onSave
  }) {
    if (givenInterval.name.isNotEmpty) {
      nameController.text = givenInterval.name;
      __name = givenInterval.name;
    }

    onMinuteChanged.value = givenInterval.minutes;
    onSecondChanged.value = givenInterval.seconds;
  }
  
  callOnSave(IntervalUnitDTO interval){
    if(onSave != null){
      onSave!(interval);
    }
  }

  @override
  Widget build(BuildContext context) {
    double side = 20;
    double top = 22;
    double bottom = 0;

    NumberPickerWidget minutePicker = NumberPickerWidget(
        currentIntValue: onMinuteChanged.value,
        onNumberChanged: onMinuteChanged);

    NumberPickerWidget secondPicker = NumberPickerWidget(
        currentIntValue: onSecondChanged.value,
        onNumberChanged: onSecondChanged);

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              children: [
                nameField,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    minutePicker,
                    Padding(
                      padding: EdgeInsets.fromLTRB(side, top, side, bottom),
                      child: Text(
                        ':',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    secondPicker
                  ],
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 16),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            foregroundColor: __name.isEmpty
                                ? Theme.of(context).disabledColor
                                : Theme.of(context).primaryColor),
                        onPressed: () => {
                              if (__name.isNotEmpty) {saveIntervall()}
                            },
                        child: const Text('save')))
              ],
            ))
      ],
    );
  }

  saveIntervall() {
    if (__name.isEmpty) {
      throw AssertionError('Name is empty take a look: ${givenInterval.name}');
    }

    IntervalUnitDTO intervalToSave = IntervalUnitDTO(
      id: givenInterval.id,
      name: __name,
      minutes: onMinuteChanged.value,
      seconds: onSecondChanged.value
    );

    IntervalUnitDTO saved = repository.save(intervalToSave);
    callOnSave(saved);
  }
}
