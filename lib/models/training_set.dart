
import 'package:objectbox/objectbox.dart';
import 'package:runningam/models/training_interval.dart';

import 'Interval.dart';

@Entity()
class TrainingSet {


  @Id()
  int id;

  @Backlink()
  final ToMany<TrainingIntervalDTO> intervals = ToMany();

  @Unique()
  final String name;

  static const String NAME = 'name';
  static const String ID = 'id';

  List<IntervalUnitDTO> getIntervalsAsSortedList(){
    List<TrainingIntervalDTO> sorted = intervals.nonNulls.toList();
    sorted.sort( (a, b) => a.position.compareTo(b.position));

    return sorted.map((e) => e.interval.target).nonNulls.toList();
  }


  TrainingSet({
    this.id = 0,
    this.name = '',
    Map<int,IntervalUnitDTO>? intervalsByPosition
  }) {
    if(intervalsByPosition != null){
      intervalsByPosition.forEach((position, interval) {
        TrainingIntervalDTO dto = TrainingIntervalDTO(position: position);
        dto.interval.target = interval;
        dto.training.target = this;
        intervals.add(dto);
      });
    }
  }
  

}