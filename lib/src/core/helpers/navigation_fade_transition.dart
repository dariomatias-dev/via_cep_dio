import 'package:flutter/material.dart';

void navigationFadeTransition(
  BuildContext context,
  String screenName,
  Widget Function() screen,
) {
  Navigator.push(
    context,
    PageRouteBuilder(
      settings: RouteSettings(
        name: screenName,
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
