import 'package:messaging/messaging.dart';

class MessagingStateLogger extends MessagingObserver{

  @override
  void onPrePublish(Message message) {
    // Informed before message is published
    super.onPrePublish(message);
  }

  @override
  void onDispatchFailed(Message message, Object error, {MessagingSubscriber? subscriber, StackTrace? trace}) {
    // Informed when an error occurred during dispatching (to an subscriber or not)
    super.onDispatchFailed(message, error, subscriber: subscriber, trace: trace);
    print('Dispatching message error $error for message ${message.toString()}');
    throw error;
  }

  @override
  void onMessagingStateChanged(MessagingState state) {
    // Informed when the state of the messaging instance changed
    super.onMessagingStateChanged(state);
  }

  @override
  void onNotAllowed(Message message, MessagingGuard guard, MessagingGuardResponse response) {
    // Informed when a message is not allowed by a guard
    super.onNotAllowed(message, guard, response);
  }

  @override
  void onPostDispatch(Message message) {
    // Informed after the message is dispatched
    super.onPostDispatch(message);
    print('Finished to dispatch message ${message.toString()}');
  }

  @override
  void onPostPublish(Message message) {
    // Informed after the message is published
    super.onPostPublish(message);
  }

  @override
  void onPreDispatch(Message message) {
    // Informed before the message is dispatched
    super.onPreDispatch(message);
    print('Start to dispatch message ${message.toString()}');
  }

  @override
  void onPublishFailed(Message message, Object error, {StackTrace? trace}) {
    // Informed when publication of a message failed for any other reason but the guard
    super.onPublishFailed(message, error, trace: trace);
    print('Publishing message error $error for message ${message.toString()}');
    throw error;

  }

  @override
  void onSaved(Message message) {
    // Informed when the message is saved in the store
    super.onSaved(message);
  }


}