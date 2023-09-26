import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/screens/add_via_cep_screen/components/add_via_cep_screen_form_widget.dart';

class AddViaCepScreen extends StatelessWidget {
  const AddViaCepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Adicionar Via Cep',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
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
      ),
      body: const SingleChildScrollView(
        child: AddViaCepScreenFormWidget(),
      ),
    );
  }
}
