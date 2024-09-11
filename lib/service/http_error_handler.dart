import 'package:http/http.dart' as http;

String httpErorHandler(http.Response response) {
  final statusCode = response.statusCode;
  final reasonPhrase = response.reasonPhrase;

  final String errorMessage =
      'Request failed\nStatuCode: $statusCode\nReason: $reasonPhrase';

  return errorMessage;
}
