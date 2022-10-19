import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';
import 'package:type_ahead/navigation/navigation.dart';
import 'package:type_ahead/screens/app/nav/app_nav_cubit.dart';
import 'package:type_ahead/model/type_ahead_model.dart';
import 'package:type_ahead/repository/type_ahead_repository.dart';

part 'type_ahead_event.dart';
part 'type_ahead_state.dart';

class TypeAheadBloc extends Bloc<TypeAheadEvent, TypeAheadState> {
  TypeAheadBloc({
    required TypeAheadRepository typeAheadRepository,
    required BaseNav navigation,
    this.eventsPerPage = 20,
  })  : _typeAheadRepository = typeAheadRepository,
        _navigation = navigation,
        super(TypeAheadState()) {
    on<InitializedEvent>((event, emit) async {});

    on<TypeAheadInputChangedEvent>((event, emit) async {
      final query = event.text;
      if (query.isEmpty) {
        emit(state.copyWith(
            events: [], page: 1, typeAheadInput: const TypeAheadInput.pure()));
        return;
      }

      emit(state.copyWith(isLoading: true));
      final fetchedEvents = await _typeAheadRepository.fetchEvents(
          page: state.page, perPage: eventsPerPage, query: query);

      final allEventsLoaded = fetchedEvents.length < eventsPerPage;
      emit(state.copyWith(
          events: fetchedEvents,
          page: state.page,
          allEventsLoaded: allEventsLoaded,
          isLoading: false,
          typeAheadInput: TypeAheadInput.dirty(value: query)));
    }, transformer: (events, mapper) {
      return events
          .debounceTime(const Duration(milliseconds: 300))
          .asyncExpand(mapper);
    });

    on<BottomListReachedEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final newPage = state.page + 1;
      final fetchedEventsToAdd = await _typeAheadRepository.fetchEvents(
          page: newPage,
          perPage: eventsPerPage,
          query: state.typeAheadInput.value);

      final allEventsLoaded = fetchedEventsToAdd.length < eventsPerPage;
      final events = state.events.toList()..addAll(fetchedEventsToAdd);
      emit(state.copyWith(
        events: events,
        page: newPage,
        allEventsLoaded: allEventsLoaded,
        isLoading: false,
      ));
    });

    on<EventTappedEvent>((event, emit) async {
      emit(state.copyWith(selectedEvent: event.event));
      _navigation.routeTo(DetailsPath());
    });

    on<CancelButtonPushedEvent>((event, emit) async {
      emit(state
          .copyWith(events: [], typeAheadInput: const TypeAheadInput.pure()));
    });
  }

  final int eventsPerPage;
  final BaseNav _navigation;
  final TypeAheadRepository _typeAheadRepository;
}
