import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runningam/models/Interval.dart';
import 'package:runningam/repository/database_service.dart';

import '../objectbox.g.dart';

class ObjBoxTest extends StatelessWidget {

  final DatabaseService db = DatabaseService();
  late Box<IntervalUnitDTO> box;


  ObjBoxTest({super.key}){
    box = db.box.store.box<IntervalUnitDTO>();
  }


  @override
  Widget build(BuildContext context) {
    List<IntervalUnitDTO> intervals = box.getAll();
    List<Widget> listElements = intervals.map((e) => ListTile(
      title: Text('$e'),
    )).toList();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  box.put(IntervalUnitDTO(name: DateTime.now().toIso8601String()));
                }, 
                child: Text('Add New')
            ),
            ListBody(
              children: listElements,
            )
          ],
        ),
      ),
    );



  }

}