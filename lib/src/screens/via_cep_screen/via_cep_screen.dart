import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/models/via_cep_model.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

class ViaCepScreen extends StatefulWidget {
  const ViaCepScreen({
    super.key,
    required this.cep,
  });

  final String cep;

  @override
  State<ViaCepScreen> createState() => _ViaCepScreenState();
}

class _ViaCepScreenState extends State<ViaCepScreen> {
  final ViaCepService viaCepService = ViaCepService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viaCepService.getViaCep(widget.cep),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 140.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('');
        }

        final ViaCepModel viaCep = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: Tooltip(
              message: 'Sair',
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              '${viaCep.localidade} - ${viaCep.uf}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: Container(),
        );
      },
    );
  }
}
