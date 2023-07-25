

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrainingPlanerWidget extends StatefulWidget {
  static const route = '/trainings';
  String title = 'Training';

  String name;

  TrainingPlanerWidget({
    super.key,
    this.name = '',
  });

  @override
  TrainingPlanerWidgetState createState() {
    return TrainingPlanerWidgetState();
  }
}

class TrainingPlanerWidgetState extends State<TrainingPlanerWidget> {
  String name;

  TextEditingController nameController = TextEditingController();
  late TextField nameField = TextField(
    controller: nameController,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Name',
    ),
    maxLength: 128,
    onChanged: (value) {
      setState(() {
        name = nameController.text;
      });
    },
  );

  TrainingPlanerWidgetState({this.name = ''}) {
    if (name.isNotEmpty) {
      nameController.text = name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            nameField,
          ],
        ),
      ),
    );
  }

}