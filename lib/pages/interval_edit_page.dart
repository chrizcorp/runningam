
import 'package:flutter/material.dart';
import 'package:runningam/widgets/interval/interval_planer_widget.dart';

import '../models/Interval.dart';

class EditIntervalUnitPage extends StatelessWidget {
  static IntervalUnitDTO DEFAULT = IntervalUnitDTO(id: -1, name: '', minutes: 0, seconds: 0);

  late IntervalUnitDTO interval;
  Function(IntervalUnitDTO interval)? onSave;

  EditIntervalUnitPage({
    super.key,
    this.onSave,
    IntervalUnitDTO? intervalUnit,
  }){
    if(intervalUnit == null){
      interval = DEFAULT;
    }
  }


  @override
  Widget build(BuildContext context) {
    String title = interval.name.isNotEmpty? interval.name : 'Add Interval';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IntervalPlanerWidget(interval: interval, onSave: onSave,),
          ],
        ),
      ),
    );
  }

}