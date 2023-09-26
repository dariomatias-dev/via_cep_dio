import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/routes/via_cep_route_names.dart';

void navigationFadeTransition(
  BuildContext screenContext,
  Widget Function() screen,
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
        return screen();
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
