import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'package:cep_dio/src/core/enums/enums.dart';
import 'package:cep_dio/src/core/rest_client/rest_client.dart';

import 'package:cep_dio/src/models/basic_cep_model.dart';
import 'package:cep_dio/src/models/cep_collection_model.dart';
import 'package:cep_dio/src/models/cep_model.dart';

import 'package:cep_dio/src/notifiers/cep_service_notifier.dart';

class CepService {
  final dioBack4app = dioConfigured();
  final logger = Logger();

  final String cardFieldKeys = 'keys=bairro,localidade,uf,cep';

  Future<void> createCep(CepModel cep) async {
    try {
      await dioBack4app.post(
        '',
        data: cep.toMap(),
      );

      cepServiceNotifier.notify();
    } catch (err, stackTrace) {
      logger.e(
        'Error: $err',
        stackTrace: stackTrace,
      );
    }
  }

  Future<BasicCepModel?> getBasicCep(cep) async {
    try {
      final String queries = '?where={"cep": "$cep"}&$cardFieldKeys';
      final Response response = await dioBack4app.get(queries);
      final List<dynamic> results = response.data['results'];

      if (results.isNotEmpty) {
        return BasicCepModel.fromMap(results[0]);
      }

      return null;
    } catch (err, stackTrace) {
      logger.e(
        'Error: $err',
        stackTrace: stackTrace,
      );

      return null;
    }
  }

  Future<CepModel?> getCep(String cepId) async {
    try {
      final String queries = '?where={"objectId": "$cepId"}';
      final Response response = await dioBack4app.get(queries);
      final List<dynamic> results = response.data['results'];

      return CepModel.fromMap(results[0]);
    } catch (err, stackTrace) {
      logger.e(
        'Error: $err',
        stackTrace: stackTrace,
      );

      return null;
    }
  }

  Future<CepCollectionModel?> getBasicCeps(int skip, int limit) async {
    try {
      final String queries = 'skip=$skip&limit=$limit&count=1';
      final Response response =
          await dioBack4app.get('?$cardFieldKeys&$queries');
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
    } catch (err, stackTrace) {
      logger.e(
        'Error: $err',
        stackTrace: stackTrace,
      );

      return null;
    }
  }

  Future<void> updateCep(String cepId, CepModel cep) async {
    try {
      await dioBack4app.put(
        cepId,
        data: cep.toMap(),
      );

      cepServiceNotifier.notify();
    } catch (err, stackTrace) {
      logger.e(
        'Error: $err',
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> deleteCep(String cepId) async {
    try {
      await dioBack4app.delete(cepId);

      cepServiceNotifier.notify();
    } catch (err, stackTrace) {
      logger.e(
        'Error: $err',
        stackTrace: stackTrace,
      );
    }
  }

  Future<BasicCepModel?> getCepByViaCep(String cep) async {
    try {
      final dioViaCep = dioConfigured(
        apiBaseUrl: BaseUrlsEnum.viaCep,
      );

      final Response response = await dioViaCep.get('$cep/json/');
      final Map<String, dynamic> data = response.data;

      final BasicCepModel basicCep = BasicCepModel.fromMap(data);

      return basicCep;
    } catch (err, stackTrace) {
      logger.e(
        'Error: $err',
        stackTrace: stackTrace,
      );

      return null;
    }
  }
}
