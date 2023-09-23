import 'package:dio/dio.dart';

import 'package:via_cep_dio/src/core/restClient/rest_client.dart';

import 'package:via_cep_dio/src/models/via_cep_model.dart';

class ViaCepService {
  final dio = dioConfigured();

  Future<ViaCepModel?> getViaCep(cep) async {
    final queries = '?where={"cep":  "$cep"}';
    final Response response = await dio.get(queries);
    final List<dynamic> results = response.data['results'];

    if (results.isNotEmpty) {
      return ViaCepModel.fromMap(results[0]);
    }

    return null;
  }

  Future<List<ViaCepModel>> getViaCeps() async {
    final Response response = await dio.get('');
    final results = response.data['results'];
    final viaCeps = (results as List<dynamic>).map((viaCepJson) {
      return ViaCepModel.fromMap(viaCepJson);
    }).toList();

    return viaCeps;
  }
}
