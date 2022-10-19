import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:type_ahead/core/http_client_headers.dart';
import 'package:type_ahead/di.dart';
import 'package:http/http.dart' as http;

import 'api_provider.dart';

class ProviderDI implements ServiceDi {
  static ApiProvider get apiProvider => getIt.get<ApiProvider>();

  static http.Client get _httpClient => getIt.get<http.Client>();

  @override
  Future<void> create(GetIt container) async {
    container
      ..registerSingletonAsync<http.Client>(
        () async {
          const username = 'Mjk3OTE5OTF8MTY2NjEwMDY0MS40NzA0ODY2';
          const password =
              '827e21b084fd3aa002f60e3429e600ac498c51952540a67122121aa4785692f6';

          final basicAuth =
              'Basic ${base64Encode(utf8.encode('$username:$password'))}';
          return HttpClientHeaders(
              defaultHeaders: <String, String>{'authorization': basicAuth});
        },
        dispose: (param) => param.close(),
      )
      ..registerSingletonAsync<ApiProvider>(() async {
        final provider = SeatGeekApiProvider(client: _httpClient);
        return provider;
      }, dependsOn: [http.Client]);
  }
}
