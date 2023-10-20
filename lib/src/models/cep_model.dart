class CepModel {
  CepModel({
    this.id,
    required this.cep,
    required this.logradouro,
    this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ibge,
    this.gia,
    required this.ddd,
    required this.siafi,
  });

  final String? id;
  final String cep;
  final String? logradouro;
  final String? complemento;
  final String? bairro;
  final String localidade;
  final String uf;
  final int ibge;
  final int? gia;
  final int ddd;
  final int siafi;

  factory CepModel.fromMap(Map<String, dynamic> map) {
    final String logradouroValue = map['logradouro'];
    final String complementoValue = map['complemento'];
    final String bairroValue = map['bairro'];
    final String giaValue = map['gia'];

    return CepModel(
      id: map['objectId'],
      cep: map['cep'],
      logradouro: logradouroValue.isNotEmpty ? logradouroValue : null,
      complemento: complementoValue.isNotEmpty ? complementoValue : null,
      bairro: bairroValue.isNotEmpty ? bairroValue : null,
      localidade: map['localidade'],
      uf: map['uf'],
      ibge: int.parse(map['ibge']),
      gia: giaValue.isNotEmpty ? int.parse(giaValue) : null,
      ddd: int.parse(map['ddd']),
      siafi: int.parse(map['siafi']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento ?? '',
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
      'ibge': ibge.toString(),
      'gia': gia != null ? gia.toString() : '',
      'ddd': ddd.toString(),
      'siafi': siafi.toString(),
    };
  }
}
