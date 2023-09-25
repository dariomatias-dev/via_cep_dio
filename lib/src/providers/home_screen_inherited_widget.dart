import 'package:flutter/material.dart';

class HomeScreenInheritedWidget extends InheritedWidget {
  const HomeScreenInheritedWidget({
    super.key,
    required this.cepToSearch,
    required this.updateCepToSearch,
    required final Widget child,
  }) : super(child: child);

  final String cepToSearch;
  final void Function(String) updateCepToSearch;

  static HomeScreenInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<HomeScreenInheritedWidget>();
  }

  @override
  bool updateShouldNotify(HomeScreenInheritedWidget oldWidget) {
    return true;
  }
}
