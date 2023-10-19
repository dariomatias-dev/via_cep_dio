import 'package:flutter/material.dart';

import 'package:cep_dio/src/screens/cep_search_screen/components/cep_search_screen_header_widget/cep_search_screen_header_widget.dart';

class CepSearchScreen extends StatefulWidget {
  const CepSearchScreen({super.key});

  @override
  State<CepSearchScreen> createState() => _CepSearchScreenState();
}

class _CepSearchScreenState extends State<CepSearchScreen> {
  String _cepToSearch = '';

  void _updateCepToSearch(String cep) {
    if (cep != _cepToSearch) {
      setState(() {
        _cepToSearch = cep;
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
      ],
    );
  }
}
