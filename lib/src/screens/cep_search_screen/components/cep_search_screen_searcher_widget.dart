import 'package:flutter/material.dart';

import 'package:cep_dio/src/models/basic_cep_model.dart';

import 'package:cep_dio/src/services/cep_service.dart';

class CepSearchScreenSearcherWidget extends StatefulWidget {
  const CepSearchScreenSearcherWidget({
    super.key,
    required this.cepToSearch,
  });

  final String? cepToSearch;

  @override
  State<CepSearchScreenSearcherWidget> createState() =>
      _CepSearchScreenSearcherWidgetState();
}

class _CepSearchScreenSearcherWidgetState
    extends State<CepSearchScreenSearcherWidget> {
  final CepService _cepService = CepService();

  Future<void> _fetchData() async {
    final BasicCepModel? basicCep = await _cepService.getCepByViaCep('58140000');
  }

  @override
  void initState() {
    _fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
