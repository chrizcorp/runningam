
import 'package:runningam/repository/database_service.dart';

import '../models/Interval.dart';
import '../objectbox.g.dart';

class IntervalRepository {
  final DatabaseService __databaseService = DatabaseService();

  late Box<IntervalUnitDTO> box;

  IntervalRepository(){
    box = __databaseService.box.store.box<IntervalUnitDTO>();
  }

  IntervalUnitDTO save(IntervalUnitDTO interval) {
    int id = box.put(
        interval
    );

    interval.id = id;
    return interval;
  }

  List<IntervalUnitDTO> getAll(){
    return box.getAll();
  }

  List<IntervalUnitDTO> getAllByIds(Iterable<int> ids){
      return box.getMany(ids.toList()).whereType<IntervalUnitDTO>().toList();
  }

}
