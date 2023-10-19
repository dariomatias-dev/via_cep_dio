import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:cep_dio/src/core/enums/enums.dart';

Dio dioConfigured({
  BaseUrlsEnum apiBaseUrl = BaseUrlsEnum.back4App,
}) {
  final Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
    'X-Parse-Application-Id': dotenv.env['APPLICATION_ID'],
    'X-Parse-REST-API-Key': dotenv.env['API_KEY'],
  };

  final String baseUrl = apiBaseUrl == BaseUrlsEnum.back4App
      ? dotenv.env['API_URL_BASE_BACK4APP']!
      : dotenv.env['API_BASE_URL_VIA_CEP']!;

  final options = BaseOptions(
    baseUrl: baseUrl,
    headers: headers,
  );

  return Dio(options);
}
