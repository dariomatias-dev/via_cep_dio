import 'package:flutter/material.dart';

import 'package:cep_dio/src/screens/cep_search_screen/components/cep_search_screen_searcher_widget.dart';

import 'package:cep_dio/src/screens/cep_search_screen/components/cep_search_screen_header_widget/cep_search_screen_header_widget.dart';

class CepSearchScreen extends StatefulWidget {
  const CepSearchScreen({super.key});

  @override
  State<CepSearchScreen> createState() => _CepSearchScreenState();
}

class _CepSearchScreenState extends State<CepSearchScreen> {
  final ValueNotifier<String?> _cepToSearchValueNotifier =
      ValueNotifier<String?>(null);

  void _updateCepToSearch(String? cep) {
    if (cep != _cepToSearchValueNotifier.value) {
      setState(() {
        _cepToSearchValueNotifier.value = cep;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CepSearchScreenHeaderWidget(
          updateCepToSearch: _updateCepToSearch,
        ),
        Expanded(
          child: Center(
            child: ListenableBuilder(
              listenable: _cepToSearchValueNotifier,
              builder: (context, child) {
                return CepSearchScreenSearcherWidget(
                  cepToSearch: _cepToSearchValueNotifier.value,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
