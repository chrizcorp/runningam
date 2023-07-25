
import 'package:flutter/material.dart';
import 'package:runningam/models/interval_unit_list.dart';
import 'package:runningam/repository/interval_repository.dart';
import 'package:runningam/widgets/interval/interval_list_widget.dart';

import '../../models/Interval.dart';
import '../../pages/interval_edit_page.dart';

class IntervalOverviewWidget extends StatefulWidget {

  static const List<IntervalUnitDTO> __empty = [];
  Iterable<IntervalUnitDTO> excepts;
  IconData intervalButtonIcon;
  final Function(IntervalUnitDTO interval)? onIntervalClicked;
  ValueNotifier? refresher;


  IntervalOverviewWidget({
    super.key,
    this.excepts = __empty,
    this.intervalButtonIcon= Icons.edit,
    this.onIntervalClicked,
    this.refresher
  });

  @override
  IntervalOverviewWidgetState createState() {
    return IntervalOverviewWidgetState(
        excepts: excepts,
        intervalButtonIcon: intervalButtonIcon,
        optionalOnIntervalClicked: onIntervalClicked
    );
  }
}

class IntervalOverviewWidgetState extends State<IntervalOverviewWidget> {


  late Function(IntervalUnitDTO interval) onIntervalClicked;
  final IntervalRepository __repository = IntervalRepository();


  IconData intervalButtonIcon;
  IntervalUnitList intervals = IntervalUnitList();
  Iterable<IntervalUnitDTO> excepts;


  IntervalOverviewWidgetState({
    required this.excepts,
    required this.intervalButtonIcon,
    Function(IntervalUnitDTO interval)? optionalOnIntervalClicked,
    ValueNotifier? refresher
  }){
      onIntervalClicked = optionalOnIntervalClicked ?? openEdit;
      fetchRepository();

      if(refresher!= null){
        refresher.addListener(() {
          setState(() {
            fetchRepository();
          });

        });
      }
  }

   fetchRepository() {
     List<IntervalUnitDTO> allIntervals = __repository.getAll();
     allIntervals.where((interval) => !excepts.contains(interval));
     intervals.set(allIntervals);
   }

  openEdit(IntervalUnitDTO unit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditIntervalUnitPage(intervalUnit: unit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        IntervalListWidget(
          intervalButtonIcon: intervalButtonIcon,
          intervals: intervals,
          onIntervalClicked: onIntervalClicked,
        )
      ],
    );
  }
}
