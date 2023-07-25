
import 'package:flutter/material.dart';
import 'package:runningam/models/Interval.dart';
import 'package:runningam/models/interval_unit_list.dart';
import 'package:runningam/widgets/interval/interval_list_element_widget.dart';

class IntervalListWidget extends StatefulWidget {
  // List<IntervalUnit> intervals;
  IntervalUnitList intervals;
  IconData intervalButtonIcon;
  final Function(IntervalUnitDTO interval) onIntervalClicked;

  IntervalListWidget({
    super.key, 
    required this.intervals,
    this.intervalButtonIcon = Icons.edit,
    required this.onIntervalClicked
  });

  @override
  IntervalListWidgetState createState() => IntervalListWidgetState(
      intervalList: intervals,
      intervalButtonIcon: intervalButtonIcon,
      onIntervalClicked: onIntervalClicked
  );


}

class IntervalListWidgetState extends State<IntervalListWidget> {
  IntervalUnitList intervalList;
  IconData intervalButtonIcon;
  final Function(IntervalUnitDTO interval) onIntervalClicked;
  List<Widget> children = List.filled(1, const ListTile(title: Text('No interval was found')));

  IntervalListWidgetState({
    required this.intervalList,
    required this.intervalButtonIcon,
    required this.onIntervalClicked,
  }){
    generateListElements();
    intervalList.addListener(() => generateListElements());
  }

  generateListElements(){
    Iterable<IntervalListElementWidget> element = intervalList.values.map((e) => IntervalListElementWidget(
      interval: e,
      buttonIcon: intervalButtonIcon,
      callBack: onIntervalClicked,
    ));

    if(element.isNotEmpty){
      children = element.toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      ListBody(
      children: children,
        )
      ],
    );

  }



}
