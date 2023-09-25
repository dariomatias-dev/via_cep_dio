import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/routes/via_cep_route_names.dart';

import 'package:via_cep_dio/src/screens/via_cep_screen/via_cep_screen.dart';

void navigationFadeTransition(
  BuildContext screenContext,
  String cep,
) {
  Navigator.push(
    screenContext,
    PageRouteBuilder(
      settings: RouteSettings(
        name: ViaCepRouteNames.viaCep,
      ),
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) {
        return ViaCepScreen(
          cep: cep,
        );
      },
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
  );
}
