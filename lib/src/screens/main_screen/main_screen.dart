import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:via_cep_dio/src/core/helpers/navigation_fade_transition.dart';

import 'package:via_cep_dio/src/providers/main_screen_inherited_widget.dart';

import 'package:via_cep_dio/src/screens/main_screen/components/main_screen_header_widget/main_screen_header_widget.dart';
import 'package:via_cep_dio/src/screens/main_screen/components/main_screen_body_content_widget/main_screen_body_content_widget/main_screen_body_content_widget.dart';
import 'package:via_cep_dio/src/screens/via_cep_form_screen/via_cep_form_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  String _cepToSearch = '';

  void _updateCepToSearch(String cep) {
    if (cep != _cepToSearch) {
      setState(() {
        _cepToSearch = cep;
      });
    }
  }

  final List<Widget> screenContents = [
    const Column(
      children: [
        MainScreenHeaderWidget(),
        MainScreenBodyContentWidget(),
      ],
    ),
    const SizedBox(
      height: 400.0,
      child: Text('Olá!'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return MainScreenInheritedWidget(
      cepToSearch: _cepToSearch,
      updateCepToSearch: _updateCepToSearch,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: screenContents.elementAt(_currentIndex),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigationFadeTransition(
              context,
              () => const ViaCepFormScreen(
                formType: 'creation',
              ),
            );
          },
          backgroundColor: Colors.black,
          icon: const Icon(
            Icons.add,
          ),
          label: const Text('Adiconar'),
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
          backgroundColor: Colors.black,
          selectedItemColor: Colors.yellow,
          selectedColorOpacity: 0.12,
          unselectedItemColor: Colors.white,
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.location_on),
              title: const Text('CEPs'),
            ),
          ],
        ),
      ),
    );
  }
}
