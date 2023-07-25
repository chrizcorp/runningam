
import 'package:messaging/messaging.dart';
import 'package:runningam/models/Interval.dart';

class CurrentIntervalMessage extends Message {
  final IntervalUnitDTO interval;

  const CurrentIntervalMessage({required this.interval}) : super(priority: 10);

}