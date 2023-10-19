import 'package:flutter/material.dart';

import 'package:cep_dio/src/models/cep_collection_model.dart';

class MainScreenInheritedWidget extends InheritedWidget {
  const MainScreenInheritedWidget({
    super.key,
    required this.skip,
    required this.limit,
    required this.cepCollection,
    required this.fetchCEPs,
    required this.cepToSearch,
    required this.updateCepToSearch,
    required final Widget child,
  }) : super(child: child);

  final int skip;
  final int limit;
  final CepCollectionModel? cepCollection;
  final Future<CepCollectionModel?> Function(int, int) fetchCEPs;
  final String cepToSearch;
  final void Function(String) updateCepToSearch;

  static MainScreenInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MainScreenInheritedWidget>();
  }

  @override
  bool updateShouldNotify(MainScreenInheritedWidget oldWidget) {
    return false;
  }
}
