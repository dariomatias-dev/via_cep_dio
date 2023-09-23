import 'package:dio/dio.dart';

Dio dioConfigured() {
  final Map<String, dynamic> headers = {
    'X-Parse-Application-Id': 'pURti5KAzYYUaVnRIQI2hrtPvXD4vVJ1OvGkUuuc',
    'X-Parse-REST-API-Key': 'v8nQNleAnsl31VYhbt14mUgbeLigsHhjSqbLXHrs',
  };

  final options = BaseOptions(
    baseUrl: 'https://parseapi.back4app.com/classes/viacep/',
    headers: headers,
  );

  return Dio(options);
}
