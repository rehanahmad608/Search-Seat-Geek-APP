part of 'type_ahead_bloc.dart';

abstract class TypeAheadEvent {
  const TypeAheadEvent();
}

class InitializedEvent extends TypeAheadEvent {
  const InitializedEvent();
}

class TypeAheadInputChangedEvent extends TypeAheadEvent {
  const TypeAheadInputChangedEvent(this.text);

  final String text;
}

class BottomListReachedEvent extends TypeAheadEvent {
  const BottomListReachedEvent();
}

class CancelButtonPushedEvent extends TypeAheadEvent {
  const CancelButtonPushedEvent();
}

class EventTappedEvent extends TypeAheadEvent {
  const EventTappedEvent(this.event);

  final EventModel event;
}
