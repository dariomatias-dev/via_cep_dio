import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/providers/home_screen_inherited_widget.dart';

import 'package:via_cep_dio/src/screens/home_screen/components/home_screen_header_widget/home_screen_header_widget.dart';
import 'package:via_cep_dio/src/screens/home_screen/components/home_screen_body_content_widget/home_screen_body_content_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String cepToSearch = '';

  void updateCepToSearch(String cep) {
    setState(() {
      cepToSearch = cep;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreenInheritedWidget(
      cepToSearch: cepToSearch,
      updateCepToSearch: updateCepToSearch,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.black,
        ),
        body: const SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomeScreenHeaderWidget(),
                HomeScreenBodyContentWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
