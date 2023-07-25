
import 'dart:async';

import 'package:messaging/messaging.dart';
import 'package:runningam/models/Interval.dart';
import 'package:runningam/services/message/currentTraining/training_current_interval_message.dart';
import 'package:uuid/uuid.dart';

class CurrentIntervalSubscriber implements MessagingSubscriber {

  static const Type TYPE = CurrentIntervalMessage;

  final Type type = TYPE;
  Function(IntervalUnitDTO) onInterval;
  late String __name;

  CurrentIntervalSubscriber({
    required this.onInterval,
    String? name ,
  }){
    __name = name?? 'CurrentIntervalSubscriber-${const Uuid().v1()}';
  }

  @override
  Future<void> onMessage(Message message) {
    Completer<void> completer = Completer();
    if(message is CurrentIntervalMessage){
      onInterval(message.interval);
      completer.complete();
    }

    return completer.future;
  }

  @override
  String get subscriberKey{
    return __name;
  }

}