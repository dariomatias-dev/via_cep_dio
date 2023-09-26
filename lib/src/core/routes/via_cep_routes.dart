import 'package:via_cep_dio/src/core/routes/via_cep_route_names.dart';

import 'package:via_cep_dio/src/screens/add_via_cep_screen/add_via_cep_screen.dart';
import 'package:via_cep_dio/src/screens/home_screen/home_screen.dart';

final viaCepRoutes = {
  ViaCepRouteNames.initial: (_) => const HomeScreen(),
  ViaCepRouteNames.addViaCep: (_) => const AddViaCepScreen(),
};
