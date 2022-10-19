import 'package:type_ahead/providers/api_provider.dart';

import 'package:type_ahead/model/type_ahead_model.dart';

abstract class TypeAheadRepository {
  Future<List<EventModel>> fetchEvents(
      {required int page, required int perPage, required String query});
}

class TypeAheadRepositorySimple implements TypeAheadRepository {
  TypeAheadRepositorySimple({
    required ApiProvider provider,
  }) : _provider = provider;
  final ApiProvider _provider;

  @override
  Future<List<EventModel>> fetchEvents(
      {required int page, required int perPage, required String query}) async {
    return _provider.fetchEvents(page: page, query: query, perPage: perPage);
  }
}
