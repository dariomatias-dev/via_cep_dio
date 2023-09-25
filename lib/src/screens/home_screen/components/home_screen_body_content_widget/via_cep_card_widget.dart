import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/navigation_fade_transition.dart';

import 'package:via_cep_dio/src/models/via_cep_card_model.dart';

class ViaCepCardWidget extends StatefulWidget {
  const ViaCepCardWidget({
    super.key,
    required this.viaCep,
  });

  final ViaCepCardModel viaCep;

  @override
  State<ViaCepCardWidget> createState() => _ViaCepCardWidgetState();
}

class _ViaCepCardWidgetState extends State<ViaCepCardWidget> {
  VoidCallback? action;

  void updateViaCep() {}

  void deleteViaCep() {}

  @override
  Widget build(BuildContext context) {
    final ViaCepCardModel viaCep = widget.viaCep;

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
      onTap: () => navigationFadeTransition(
        context,
        viaCep.cep,
      ),
    );
  }
}
