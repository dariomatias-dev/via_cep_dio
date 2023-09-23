import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/models/via_cep_model.dart';

import 'package:via_cep_dio/src/services/via_cep_repository.dart';

class CepListWidget extends StatefulWidget {
  const CepListWidget({super.key});

  @override
  State<CepListWidget> createState() => _CepListWidgetState();
}

class _CepListWidgetState extends State<CepListWidget> {
  final ViaCepService viaCepService = ViaCepService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viaCepService.getViaCeps(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Ocorreu um problema ao carregar os dados');
        } else if (snapshot.data == null) {
          return const Text('Dados não existem');
        }

        final List<ViaCepModel> viaCeps = snapshot.data!;

        return Column(
          children: viaCeps.map((viaCep) {
            return ListTile(
              leading: const Icon(Icons.map),
              title: Text('${viaCep.localidade} - ${viaCep.uf}'),
              subtitle: Text(viaCep.cep),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              ),
              onTap: () {},
            );
          }).toList(),
        );
      },
    );
  }
}
