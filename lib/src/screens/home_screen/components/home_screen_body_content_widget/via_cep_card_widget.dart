import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/navigation_fade_transition.dart';

import 'package:via_cep_dio/src/models/via_cep_card_model.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

class ViaCepCardWidget extends StatefulWidget {
  const ViaCepCardWidget({
    super.key,
    required this.viaCep,
    required this.updateScreen,
  });

  final ViaCepCardModel viaCep;
  final VoidCallback updateScreen;

  @override
  State<ViaCepCardWidget> createState() => _ViaCepCardWidgetState();
}

class _ViaCepCardWidgetState extends State<ViaCepCardWidget> {
  final ViaCepService viaCepService = ViaCepService();

  void updateViaCep() {}

  @override
  Widget build(BuildContext context) {
    final ViaCepCardModel viaCep = widget.viaCep;

    return ListTile(
      leading: const Icon(Icons.map),
      title: Text('${viaCep.localidade} - ${viaCep.uf}'),
      subtitle: Text(viaCep.cep),
      trailing: PopupMenuButton(
        onSelected: (action) {
          if (action == 'update') {
          } else {
            viaCepService.deleteViaCep(viaCep.id);
          }
          widget.updateScreen();
        },
        itemBuilder: (context) => <PopupMenuEntry>[
          const PopupMenuItem(
            value: 'update',
            child: Text('Atualizar'),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Text('Excluir'),
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
