class BasicCepModel {
  BasicCepModel({
    required this.id,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.cep,
  });

  final String id;
  final String bairro;
  final String localidade;
  final String uf;
  final String cep;

  factory BasicCepModel.fromMap(Map<String, dynamic> map) {
    return BasicCepModel(
      id: map['objectId'],
      bairro: map['bairro'],
      localidade: map['localidade'],
      uf: map['uf'],
      cep: map['cep'],
    );
  }
}
