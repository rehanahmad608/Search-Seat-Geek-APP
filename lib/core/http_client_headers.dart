import 'package:http/http.dart';

class HttpClientHeaders extends BaseClient {
  HttpClientHeaders({required this.defaultHeaders});

  final Client _httpClient = Client();
  final Map<String, String> defaultHeaders;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.addAll(defaultHeaders);
    return _httpClient.send(request);
  }

  @override
  void close() {
    _httpClient.close();
  }
}
