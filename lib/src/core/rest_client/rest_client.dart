import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Dio dioConfigured() {
  final Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
    'X-Parse-Application-Id': dotenv.env['APPLICATION_ID'],
    'X-Parse-REST-API-Key': dotenv.env['API_KEY'],
  };

  final options = BaseOptions(
    baseUrl: dotenv.env['API_URL_BASE']!,
    headers: headers,
  );

  return Dio(options);
}
