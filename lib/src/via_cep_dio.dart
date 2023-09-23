import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/routes/via_cep_routes.dart';

class ViaCepDio extends StatelessWidget {
  const ViaCepDio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Via Cep',
      routes: viaCepRoutes,
    );
  }
}
