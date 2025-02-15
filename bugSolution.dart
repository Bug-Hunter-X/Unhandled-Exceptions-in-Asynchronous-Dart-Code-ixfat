```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw HttpException('Failed to load data. Status code: ${response.statusCode}', Uri.parse('https://api.example.com/data'), response.body);
    }
  } on SocketException catch (e) {
    throw Exception('No Internet Connection: $e');
  } on FormatException catch (e) {
    throw Exception('Invalid JSON format: $e');
  } on http.ClientException catch (e) {
    throw Exception('HTTP client error: $e');
  } catch (e) {
    // Log the error with more context
    print('Unexpected error fetching data: $e');
    rethrow; 
  }
}

class HttpException implements Exception {
  final String message;
  final Uri uri;
  final String responseBody;

  HttpException(this.message, this.uri, this.responseBody);

  @override
  String toString() => 'HttpException: $message, Uri: $uri, Response Body: $responseBody';
}
```