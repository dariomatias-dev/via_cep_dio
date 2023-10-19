import 'package:flutter/material.dart';

import 'package:cep_dio/src/core/routes/cep_routes.dart';

class CepDioApp extends StatelessWidget {
  const CepDioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Via CEP',
      routes: cepRoutes,
    );
  }
}
