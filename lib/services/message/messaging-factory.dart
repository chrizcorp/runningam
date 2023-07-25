import 'dart:async';

import 'package:messaging/messaging.dart';
import 'package:runningam/services/message/messaging-state-logger.dart';

class MessagingFactory {

  static final MessagingFactory  __instance = MessagingFactory._internal();
  factory MessagingFactory () => __instance;

  late Future<void> onInitialized = messaging.start();

  final Messaging messaging = Messaging(
    observers: [MessagingStateLogger()],
  );

  MessagingFactory._internal();

}