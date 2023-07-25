import 'package:runningam/models/training_set.dart';
import 'package:runningam/objectbox.g.dart';
import 'package:runningam/repository/interval_repository.dart';
import 'package:runningam/repository/training_interval_repository.dart';

import 'database_service.dart';
class TrainingSetRepository {

  final DatabaseService __databaseService = DatabaseService();
  final TrainingIntervalRepository trainingIntervalRepository = TrainingIntervalRepository();
  late Box<TrainingSet> box;


  final IntervalRepository intervalRepository = IntervalRepository();

  TrainingSetRepository () {
   box =  __databaseService.box.store.box<TrainingSet>();
  }

  List<TrainingSet> getAll(){
    return box.getAll();
  }

  TrainingSet save(TrainingSet set){
    trainingIntervalRepository.deleteByTrainingSet(set);
    box.put(set);
    return set;
  }

}
