import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:type_ahead/generated/locale_keys.g.dart';

enum RangeInputError {
  empty(LocaleKeys.type_ahead_input_error_too_long);

  const RangeInputError(this.description);

  final String description;
}

class TypeAheadInput extends FormzInput<String, RangeInputError> {
  const TypeAheadInput.pure() : super.pure('');

  const TypeAheadInput.dirty({String value = ''}) : super.dirty(value);

  @override
  RangeInputError? validator(String value) {
    if (value.length > 100) {
      return RangeInputError.empty;
    }

    return null;
  }
}

class EventModel extends Equatable {
  const EventModel({
    required this.id,
    required this.title,
    required this.venue,
    required this.date,
    required this.image,
  });

  final String id;
  final String title;
  final String venue;
  final DateTime date;
  final String image;

  @override
  List<Object?> get props => [id, title, venue, date, image];

  EventModel copyWith({
    String? id,
    String? title,
    String? venue,
    DateTime? date,
    String? image,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      venue: venue ?? this.venue,
      date: date ?? this.date,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'venue': venue,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: (map['id'] as int).toString(),
      title: map['title'] as String,
      venue: map['venue']['display_location'] as String,
      date: DateTime.parse(map['datetime_utc']),
      image: _getImage(map),
    );
  }

  static String _getImage(Map<String, dynamic> map) {
    final performers = map['performers'] as List;
    final image = performers.first['image'];
    if (image is String) {
      return image;
    }
    return '';
  }
}

typedef Favorites = Set<String>;
