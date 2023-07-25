import 'package:runningam/models/Interval.dart';

abstract class IntervalService {

  static int getDurationInSeconds(IntervalUnitDTO intervalUnitDTO){
    return (intervalUnitDTO.minutes * 60) + intervalUnitDTO.seconds;
  }

  static String getInitialDurationString(IntervalUnitDTO interval ){
    return getDurationString(interval.minutes, interval.seconds);
  }

  static String getDurationStringsForSeconds(int seconds){
    int minutes = (seconds / 60).floor();
    int restSeconds = seconds % 60;

    return getDurationString(minutes, restSeconds);

  }

  static String getDurationString(int min , int sec){
    String minutes = __getPronouncing(min, 'minute');
    String seconds = __getPronouncing(sec, 'second');

    if(minutes.isEmpty && seconds.isEmpty){
      return '';
    }

    return [minutes, seconds].join(' and ');
  }

  static String __getPronouncing(int amount , String singular){
    String text ='';
    switch(amount){
      case 0:
        break;
      case 1:
        text = '1 $singular';
        break;
      default:
        text = '$amount ${singular}s';
        break;
    }

    return text;
  }

}