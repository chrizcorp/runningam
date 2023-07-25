
import 'dart:math';

import 'package:objectbox/objectbox.dart';

@Entity()
class IntervalUnitDTO{
  static const String NAME = "name";
  static const String MINUTES = "minutes";
  static const String SECONDS = "seconds";

  @Id()
  int id;
  final String name;
  final int minutes;
  final int seconds;

  IntervalUnitDTO({
    this.id = 0,
    this.name = '',
    this.minutes = 0,
    this.seconds = 0
  });

  String durationToClockString(){
    String clockString = '';
    if(minutes <= 9) {
      clockString += '0';
    }
    
    clockString += '$minutes';

    if(seconds <= 9) {
      clockString += '0';
    }
    
    clockString += '$seconds';
    return clockString;
  }
  
}

