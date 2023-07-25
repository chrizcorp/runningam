
import 'package:flutter/material.dart';
import 'package:runningam/models/training_set.dart';
import 'package:runningam/widgets/trainingset/training_set_list_element.dart';

import '../../models/training_set_list.dart';
import '../../pages/training_use_page.dart';
import '../../pages/training_set_edit_page.dart';

class TrainingSetOverviewWidget extends StatefulWidget {
  TrainingSetList trainingSetList;
  ValueNotifier<int>? needRefresh;
  
  TrainingSetOverviewWidget({
    super.key,
    required this.trainingSetList,
    this.needRefresh
  });
  
  @override
  State<StatefulWidget> createState() {
    return TrainingSetOverviewWidgetState(trainingSetList: trainingSetList);
  }
}
 
class TrainingSetOverviewWidgetState extends State<TrainingSetOverviewWidget>{
  TrainingSetList trainingSetList;
  List<TrainingSetListElement> children = [];
  ValueNotifier<int>? needRefresh;
  
  TrainingSetOverviewWidgetState({
    required this.trainingSetList,
    this.needRefresh
  });

  @override
  Widget build(BuildContext context) {
    generateElements(context);

    return Column(
      children: [
        ListBody(
          children: children,
        )
      ],
    );

  }

  gotToEdit(BuildContext context, TrainingSet set){
    Navigator.push(
      context,
        MaterialPageRoute(
            builder: (context) => TrainingIntervalEditPage(
                trainingSet: set,
                onSave: (set) => {
                  Navigator.pop(context,set),
                  if(needRefresh != null){
                    needRefresh!.value +=1
                  }
                }
            ))
    ).then((value) => {
      if(needRefresh != null){

        //TODO the list does not refresh correctly
        needRefresh!.value +=1
      }
    });
  }

  doTrain(BuildContext context, TrainingSet set){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TrainingUsePage(training: set))
    );
  }

  generateElements(BuildContext context){

    Iterable<TrainingSetListElement> element = trainingSetList.values
        .map((e) => createElement(context, e));

    if(element.isNotEmpty){
      setState(() {
        children = element.toList();
      });
    }
  }

  TrainingSetListElement createElement(BuildContext context, TrainingSet dto){
    Widget trailing = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
            onPressed: () => { doTrain(context, dto)},
            child: const Icon(Icons.play_arrow)),
        ElevatedButton(
            onPressed: () => {gotToEdit(context, dto)},
            child: const Icon(Icons.edit)
        )
      ],
    )
    ;

    return TrainingSetListElement(set: dto, trailingWidget: trailing);
  }


}

