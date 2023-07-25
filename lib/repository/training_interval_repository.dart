

import 'package:runningam/models/Interval.dart';
import 'package:runningam/models/training_interval.dart';
import 'package:runningam/models/training_set.dart';
import 'package:runningam/objectbox.g.dart';
import 'package:runningam/repository/database_service.dart';

class TrainingIntervalRepository {
  final DatabaseService __databaseService = DatabaseService();

  late Box<TrainingIntervalDTO> box;

  TrainingIntervalRepository(){
    box = __databaseService.box.store.box<TrainingIntervalDTO>();
  }

  /// deletes every traininginterval with the given trainingset
  /// @return the amount of deleted elements
  int deleteByTrainingSet(TrainingSet set){
    return __getSetQuery(set).build().remove();
  }


  List<TrainingIntervalDTO> getByTrainingSet(TrainingSet set){
    return __getSetQuery(set).build().find();
  }

  /// @return a list of the inserted ids
  saveAll(List<TrainingIntervalDTO> intervals){
    return box.putMany(intervals);
  }

  QueryBuilder<TrainingIntervalDTO> __getSetQuery(TrainingSet set){
    QueryBuilder<TrainingIntervalDTO> builder = box.query();
    builder.link(
        TrainingIntervalDTO_.training,
        TrainingSet_.id.equals(set.id)
    );
    return builder;
  }

}