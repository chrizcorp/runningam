
import 'package:flutter/widgets.dart';
import 'package:runningam/models/training_set.dart';


class TrainingSetList with ChangeNotifier {
  final List<TrainingSet> _values = [];
  List<TrainingSet> get values => _values.toList(); // O(N), makes a new copy each time.

  void set(Iterable<TrainingSet> sets) {
    _values.clear();
    _values.addAll(sets);
    notifyListeners();
  }
}
