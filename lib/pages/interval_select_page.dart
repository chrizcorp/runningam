
import 'package:flutter/material.dart';
import 'package:runningam/models/Interval.dart';
import 'package:runningam/pages/interval_edit_page.dart';
import 'package:runningam/widgets/interval/interval_overview_widget.dart';

class IntervalSelectPage extends StatelessWidget{

  static const List<IntervalUnitDTO> __empty= [];
  Iterable<IntervalUnitDTO> exceptions = [];

  IntervalSelectPage({super.key, this.exceptions = __empty});

  ValueNotifier refreshOverview = ValueNotifier(0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Interval'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => goToEditIntervalPage(context),
                child: const Text('Add Interval')
            ),
            IntervalOverviewWidget(
                excepts: exceptions,
                intervalButtonIcon: Icons.add,
              onIntervalClicked: addToContextAndGoBack(context),
            )
          ],
        ),
      ),
    );
  }

  goToEditIntervalPage(BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => EditIntervalUnitPage(
          key: key,
          onSave: (interval) => {
            Navigator.pop(context,interval),
            refreshOverview.value +=1
          }
        ))
    );
  }

  Function(IntervalUnitDTO) addToContextAndGoBack(BuildContext context){
    return (intervalUnit) => {
      Navigator.pop(context, intervalUnit)
    };
  }



}