import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:via_cep_dio/src/via_cep_dio.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(const ViaCepDio());
}
