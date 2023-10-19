import 'package:flutter/material.dart';

import 'package:cep_dio/src/screens/cep_search_screen/components/cep_search_screen_header_widget/cep_search_input_widget.dart';

class CepSearchScreenHeaderWidget extends StatelessWidget {
  const CepSearchScreenHeaderWidget({
    super.key,
    required this.updateCepToSearch,
  });

  final void Function(String) updateCepToSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 26.0,
        right: 24.0,
        bottom: 8.0,
        left: 24.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Via CEP',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          CepSearchScreenFieldWidget(
            updateCepToSearch: updateCepToSearch,
          ),
        ],
      ),
    );
  }
}
