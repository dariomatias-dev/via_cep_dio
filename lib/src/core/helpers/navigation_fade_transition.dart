import 'package:flutter/material.dart';

import 'package:cep_dio/src/core/routes/cep_route_names.dart';

void navigationFadeTransition(
  BuildContext context,
  Widget Function() screen,
) {
  Navigator.push(
    context,
    PageRouteBuilder(
      settings: RouteSettings(
        name: CepRouteNames.cep,
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
