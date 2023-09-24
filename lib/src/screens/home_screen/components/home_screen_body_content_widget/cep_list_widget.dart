import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/models/via_cep_model.dart';

class CepListWidget extends StatefulWidget {
  const CepListWidget({
    super.key,
    required this.viaCeps,
  });

  final List<ViaCepModel> viaCeps;

  @override
  State<CepListWidget> createState() => _CepListWidgetState();
}

class _CepListWidgetState extends State<CepListWidget> {
  VoidCallback? action;

  void updateViaCep() {}

  void deleteViaCep() {}

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: widget.viaCeps.map((viaCep) {
        return ListTile(
          leading: const Icon(Icons.map),
          title: Text('${viaCep.localidade} - ${viaCep.uf}'),
          subtitle: Text(viaCep.cep),
          trailing: PopupMenuButton(
            onSelected: (value) {
              action = value;
              action!();
            },
            itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: updateViaCep,
                child: const Text('Atualizar'),
              ),
              PopupMenuItem(
                value: deleteViaCep,
                child: const Text('Excluir'),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
