import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/screens/home_screen/components/cep_add_button_widget.dart';
import 'package:via_cep_dio/src/screens/home_screen/components/cep_list_widget.dart';
import 'package:via_cep_dio/src/screens/home_screen/components/header_widget/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(),
              CepListWidget(),
              CepAddButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
