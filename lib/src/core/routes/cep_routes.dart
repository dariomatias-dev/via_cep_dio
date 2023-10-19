import 'package:cep_dio/src/core/routes/cep_route_names.dart';

import 'package:cep_dio/src/screens/main_screen/main_screen.dart';

final cepRoutes = {
  CepRouteNames.initial: (_) => const MainScreen(),
};
