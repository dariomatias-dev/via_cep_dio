import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/providers/main_screen_inherited_widget.dart';

import 'package:via_cep_dio/src/screens/main_screen/components/main_screen_header_widget/main_screen_header_widget.dart';
import 'package:via_cep_dio/src/screens/main_screen/components/main_screen_body_content_widget/main_screen_body_content_widget/main_screen_body_content_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String cepToSearch = '';

  void _updateCepToSearch(String cep) {
    if (cep != cepToSearch) {
      setState(() {
        cepToSearch = cep;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenInheritedWidget(
      cepToSearch: cepToSearch,
      updateCepToSearch: _updateCepToSearch,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.black,
        ),
        body: const SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MainScreenHeaderWidget(),
                MainScreenBodyContentWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
