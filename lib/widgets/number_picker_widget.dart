import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberPickerWidget extends StatefulWidget {
  NumberPickerWidget({
    super.key,
    final String title = '',
    int currentIntValue = 0,
    int maxValue = 60,
    int step = 1,
    required this.onNumberChanged
  });

  ValueNotifier<int> onNumberChanged;

  @override
  NumberPickerState createState() {
    return NumberPickerState(onNumberChanged: this.onNumberChanged);
  }
}

class NumberPickerState extends State<NumberPickerWidget> {


  ValueNotifier<int> onNumberChanged;
  
  String __title = '';
  int __currentIntValue = 0;
  int __maxValue = 60;
  int __step = 1;

  NumberPickerState({
    String title = '',
    int currentIntValue = 0,
    int maxValue = 60,
    int step = 1,
    required this.onNumberChanged
  }) : __step = step, __maxValue = maxValue, __currentIntValue = currentIntValue, __title = title;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(__title, style: Theme
            .of(context)
            .textTheme
            .titleLarge),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              color: Theme.of(context).primaryColorDark,
              icon: const Icon(Icons.remove),
              onPressed: () =>
                  setState(() {
                    final newValue = __currentIntValue - __step;
                    __currentIntValue = newValue.clamp(0, __maxValue);
                  }),
            ),
            NumberPicker(
              value: __currentIntValue,
              minValue: 0,
              maxValue: __maxValue,
              step: __step,
              haptics: true,
              onChanged: (value) => setState(() => {
                __currentIntValue = value,
                onNumberChanged.value = value
              } ),
            ),
            IconButton(
              color: Theme.of(context).primaryColorDark,
              icon: const Icon(Icons.add),
              onPressed: () =>
                  setState(() {
                    final newValue = __currentIntValue + __step;
                    __currentIntValue = newValue.clamp(0, __maxValue);
                  }),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    onNumberChanged.dispose();
    super.dispose();
  }
}
