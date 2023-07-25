import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/Interval.dart';

class IntervalListElementWidget extends StatelessWidget {
  IntervalUnitDTO interval;
  IconData buttonIcon;
  final Function(IntervalUnitDTO intervalUnit) callBack;

  IntervalListElementWidget({
    super.key,
    required this.interval,
    required this.buttonIcon,
    required this.callBack
  });

  void onClick(){
    callBack(interval);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${interval.minutes}:${interval.seconds}'),
        subtitle: Text(interval.name),
        trailing: ElevatedButton(
          onPressed: onClick,
          child: Icon(buttonIcon),
        ),
      ),
    );

  }



}