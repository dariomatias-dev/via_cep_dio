import 'package:flutter/material.dart';

class MainScreenInheritedWidget extends InheritedWidget {
  const MainScreenInheritedWidget({
    super.key,
    required this.cepToSearch,
    required this.updateCepToSearch,
    required final Widget child,
  }) : super(child: child);

  final String cepToSearch;
  final void Function(String) updateCepToSearch;

  static MainScreenInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MainScreenInheritedWidget>();
  }

  @override
  bool updateShouldNotify(MainScreenInheritedWidget oldWidget) {
    return true;
  }
}
