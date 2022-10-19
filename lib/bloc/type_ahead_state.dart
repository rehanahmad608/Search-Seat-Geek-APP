part of 'type_ahead_bloc.dart';

class TypeAheadState extends Equatable {
  TypeAheadState({
    List<EventModel> events = const [],
    this.typeAheadInput = const TypeAheadInput.pure(),
    this.selectedEvent,
    this.page = 1,
    this.allEventsLoaded = false,
    this.isLoading = false,
  }) : events = UnmodifiableListView(events);

  final TypeAheadInput typeAheadInput;
  final List<EventModel> events;
  final EventModel? selectedEvent;
  final int page;
  final bool allEventsLoaded;
  final bool isLoading;

  @override
  List<Object?> get props {
    return [
      typeAheadInput,
      events,
      selectedEvent,
      page,
      allEventsLoaded,
      isLoading,
    ];
  }

  TypeAheadState copyWith({
    TypeAheadInput? typeAheadInput,
    List<EventModel>? events,
    EventModel? selectedEvent,
    int? page,
    bool? allEventsLoaded,
    bool? isLoading,
  }) {
    return TypeAheadState(
      typeAheadInput: typeAheadInput ?? this.typeAheadInput,
      events: events ?? this.events,
      selectedEvent: selectedEvent ?? this.selectedEvent,
      page: page ?? this.page,
      allEventsLoaded: allEventsLoaded ?? this.allEventsLoaded,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
