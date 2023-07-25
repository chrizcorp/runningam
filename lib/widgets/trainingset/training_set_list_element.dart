

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/training_set.dart';

class TrainingSetListElement extends StatelessWidget {

  TrainingSet set;
  Widget? trailingWidget;

  TrainingSetListElement({
    super.key,
    required this.set,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(set.name),
        trailing: trailingWidget,
      ),
    );
  }

}