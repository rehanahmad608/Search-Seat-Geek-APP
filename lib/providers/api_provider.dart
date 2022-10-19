import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:type_ahead/core/exception.dart';

import 'package:type_ahead/model/type_ahead_model.dart';

abstract class ApiProvider {
  Future<List<EventModel>> fetchEvents(
      {required int page, required int perPage, required String query});
}

class SeatGeekApiProvider implements ApiProvider {
  SeatGeekApiProvider({
    required http.Client client,
  }) : _client = client;
  final http.Client _client;

  static final Uri _api = Uri.https('api.seatgeek.com', '/2');

  @override
  Future<List<EventModel>> fetchEvents({
    required int page,
    required int perPage,
    required String query,
  }) async {
    final queryParameters = {
      'q': query,
      'page': page.toString(),
      'per_page': perPage.toString(),
    };
    final url =
        Uri.https(_api.authority, '${_api.path}/events', queryParameters);

    final response = await _client.get(url);
    if (response.statusCode != 200) {
      throw ApiProviderException('Wrong response code (${response.statusCode})',
          details: response.body);
    }
    try {
      final decoded = jsonDecode(response.body);
      final events = decoded['events'] as List;
      final result = events.map((event) => EventModel.fromMap(event));
      return result.toList();
    } catch (e) {
      throw ApiProviderException('Wrong format data', details: e);
    }
  }
}

class ApiProviderException extends BaseException {
  ApiProviderException(super.message, {super.details});
}
