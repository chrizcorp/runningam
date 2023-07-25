
import 'package:flutter/material.dart';
import 'package:runningam/models/Interval.dart';
import 'package:runningam/models/interval_unit_list.dart';
import 'package:runningam/widgets/interval/interval_list_element_widget.dart';

class IntervalOrderListWidget extends StatefulWidget {
  // List<IntervalUnit> intervals;
  IntervalUnitOrderedList intervals;
  IconData intervalButtonIcon;
  IntervalUnitOrderedList onIntervalListUpdate = IntervalUnitOrderedList();


  IntervalOrderListWidget({
    super.key, 
    required this.intervals,
    this.intervalButtonIcon = Icons.remove,
  });

  @override
  IntervalOrderListWidgetState createState() => IntervalOrderListWidgetState(
    intervalList: intervals,
    intervalButtonIcon: intervalButtonIcon,
    onIntervalListUpdate: onIntervalListUpdate,
  );

}

class IntervalOrderListWidgetState extends State<IntervalOrderListWidget> {
  IntervalUnitOrderedList intervalList;
  IntervalUnitOrderedList onIntervalListUpdate;
  IconData intervalButtonIcon;

  List<IntervalUnitDTO> intervals = [];
  List<Widget> children = List.filled(1, const ListTile(
      key: Key('0'),
      title: Text('No interval was found')
  ));

  IntervalOrderListWidgetState({
    required this.intervalList,
    required this.intervalButtonIcon,
    required this.onIntervalListUpdate
  }){
    intervalList.addListener(() {
      setState(() {
        generateIntervals();
      });
    });

    generateIntervals();
  }

  generateIntervals(){
      intervals = [];
      intervalList.values.forEach(
              (position, interval) => intervals.insert(position, interval)
      );

      if(intervals.isNotEmpty){
        children = generateChildren(intervals);
      }
  }

  @override
  Widget build(BuildContext context) {

    //TODO nach dem rebuild der training set edit sind die intervals wieder mit ursprünglichen wert nachdem es eigentlich schon aktualisiert sind

    return Column(
      children: [
        ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          setState(() {

            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            final IntervalUnitDTO interval = intervals.removeAt(oldIndex);
            intervals.insert(newIndex, interval);

            final Widget item = children.removeAt(oldIndex);
            children.insert(newIndex, item);

            onIntervalListUpdate.set(intervals.asMap());
          });
        },
          shrinkWrap: true,
          children: children,
        )
      ],
    );
  }


  onIntervalClicked(IntervalUnitDTO intervalUnit){
    setState(() {
      intervals.remove(intervalUnit);
      children = generateChildren(intervals);
      onIntervalListUpdate.set(intervals.asMap());
    });
  }

  List<IntervalListElementWidget> generateChildren(List<IntervalUnitDTO> intervals){
    List<IntervalListElementWidget> element = [];

    intervals.asMap().forEach((position,e) => element.insert(
        position,
        IntervalListElementWidget(
          key: Key('$position'),
          interval: e,
          buttonIcon: intervalButtonIcon,
          callBack: onIntervalClicked,
        )
    ));

    return element;
  }


}
