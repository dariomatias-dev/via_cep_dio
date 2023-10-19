import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:cep_dio/src/core/helpers/navigation_fade_transition.dart';

import 'package:cep_dio/src/models/cep_collection_model.dart';

import 'package:cep_dio/src/providers/main_screen_inherited_widget.dart';

import 'package:cep_dio/src/screens/cep_form_screen/cep_form_screen.dart';
import 'package:cep_dio/src/screens/cep_list_view_screen/cep_list_view_screen.dart';
import 'package:cep_dio/src/screens/cep_search_screen/cep_search_screen.dart';

import 'package:cep_dio/src/services/cep_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final CepService _cepService = CepService();

  int _currentIndex = 0;

  int _skip = 0;
  final _limit = 8;
  CepCollectionModel? _cepCollection = CepCollectionModel.empty();

  final List<Widget> _screenContents = [
    const CepSearchScreen(),
    const CepListViewScreen(),
  ];

  Future<CepCollectionModel?> _fetchCEPs(int skip, int limit) async {
    final cepCollection = await _cepService.getBasicCeps(
      skip,
      limit,
    );

    _cepCollection = cepCollection;
    _skip = skip;

    return cepCollection;
  }

  @override
  void initState() {
    _fetchCEPs(
      _skip,
      _limit,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenInheritedWidget(
      skip: _skip,
      limit: _limit,
      cepCollection: _cepCollection,
      fetchCEPs: _fetchCEPs,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: _currentIndex == 1 ? null : 0,
          backgroundColor: Colors.black,
          title: _currentIndex == 1
              ? const Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    'CEPs cadastrados',
                    style: TextStyle(
                      color: Colors.yellow,
                    ),
                  ),
                )
              : null,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: _screenContents.elementAt(_currentIndex),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigationFadeTransition(
              context,
              () => const CepFormScreen(
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
