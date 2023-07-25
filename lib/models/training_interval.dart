
import 'package:objectbox/objectbox.dart';
import 'package:runningam/models/training_set.dart';

import 'Interval.dart';

@Entity()
class TrainingIntervalDTO{

  @Id()
  int id;

  @Index()
  final training = ToOne<TrainingSet>();

  @Index()
  final interval = ToOne<IntervalUnitDTO>();

  int position;

  TrainingIntervalDTO({
    this.id = 0,
    required this.position
});

}