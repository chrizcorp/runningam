
import 'package:flutter/widgets.dart';

import 'Interval.dart';

class IntervalUnitList with ChangeNotifier {
  final List<IntervalUnitDTO> _values = [];
  List<IntervalUnitDTO> get values => _values.toList(); // O(N), makes a new copy each time.

  void set(Iterable<IntervalUnitDTO> intervals) {
    _values.clear();
    _values.addAll(intervals);
    notifyListeners();
  }
}


class IntervalUnitOrderedList with ChangeNotifier {
  final Map<int, IntervalUnitDTO> _values = {};
  Map<int,IntervalUnitDTO> get values => _values.map((key, value) => MapEntry(key,value)); // O(N), makes a new copy each time.

  void set(Map<int,IntervalUnitDTO> intervalsByPosition) {
    _values.clear();
    _values.addAll(intervalsByPosition);
    notifyListeners();
  }
}