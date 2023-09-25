import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/routes/via_cep_route_names.dart';

import 'package:via_cep_dio/src/models/via_cep_card_model.dart';

import 'package:via_cep_dio/src/screens/via_cep_screen/via_cep_screen.dart';

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
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            settings: RouteSettings(
              name: ViaCepRouteNames.viaCep,
            ),
            pageBuilder: (
              context,
              animation,
              secondaryAnimation,
            ) {
              return ViaCepScreen(
                cep: viaCep.cep,
              );
            },
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
    );
  }
}
