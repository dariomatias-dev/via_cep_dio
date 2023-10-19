import 'package:dio/dio.dart';

import 'package:cep_dio/src/core/rest_client/rest_client.dart';

import 'package:cep_dio/src/models/basic_cep_model.dart';
import 'package:cep_dio/src/models/cep_collection_model.dart';
import 'package:cep_dio/src/models/cep_model.dart';

import 'package:cep_dio/src/notifiers/cep_service_notifier.dart';

class CepService {
  final dio = dioConfigured();

  final String cardFieldKeys = 'keys=bairro,localidade,uf,cep';

  Future<void> createCep(CepModel cep) async {
    await dio.post(
      '',
      data: cep.toMap(),
    );
    cepServiceNotifier.notify();
  }

  Future<BasicCepModel?> getBasicCep(cep) async {
    final String queries = '?where={"cep": "$cep"}&$cardFieldKeys';
    final Response response = await dio.get(queries);
    final List<dynamic> results = response.data['results'];

    if (results.isNotEmpty) {
      return BasicCepModel.fromMap(results[0]);
    }

    return null;
  }

  Future<CepModel> getCep(String cepId) async {
    final String queries = '?where={"objectId": "$cepId"}';
    final Response response = await dio.get(queries);
    final List<dynamic> results = response.data['results'];

    return CepModel.fromMap(results[0]);
  }

  Future<CepCollectionModel?> getBasicCeps(int skip, int limit) async {
    try {
      final String queries = 'skip=$skip&limit=$limit&count=1';
      final Response response = await dio.get('?$cardFieldKeys&$queries');
      final Map<String, dynamic> data = response.data;
      final List<dynamic> results = data['results'];
      final int count = data['count'];
      final List<BasicCepModel> basicCeps = results.map((
        result,
      ) {
        return BasicCepModel.fromMap(
          result,
        );
      }).toList();

      return CepCollectionModel(
        results: basicCeps,
        count: count,
      );
    } catch (err) {
      return CepCollectionModel.empty();
    }
  }

  Future<void> updateCep(String cepId, CepModel cep) async {
    await dio.put(
      cepId,
      data: cep.toMap(),
    );
    cepServiceNotifier.notify();
  }

  Future<void> deleteCep(String cepId) async {
    await dio.delete(cepId);
    cepServiceNotifier.notify();
  }
}
