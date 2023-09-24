class ViaCepModel {
  ViaCepModel({
    required this.objectId,
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ibge,
    this.gia,
    required this.ddd,
    required this.siafi,
    required this.createdAt,
    required this.updatedAt,
  });

  final String objectId;
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final int ibge;
  final int? gia;
  final int ddd;
  final int siafi;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ViaCepModel.fromMap(Map<String, dynamic> map) {
    return ViaCepModel(
      objectId: map['objectId'],
      cep: map['cep'],
      logradouro: map['logradouro'],
      complemento: map['complemento'],
      bairro: map['bairro'],
      localidade: map['localidade'],
      uf: map['uf'],
      ibge: int.parse(map['ibge']),
      gia: (map['gia'] as String).isNotEmpty ? int.parse(map['gia']) : null,
      ddd: int.parse(map['ddd']),
      siafi: int.parse(map['siafi']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
