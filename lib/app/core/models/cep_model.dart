import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CepModel {
  String? cep;
  String? road;
  String? complement;
  String? unity;
  String? neighborhood;
  String? city;
  String? state;
  String? ibge;
  String? gia;
  String? ddd;
  String? siafi;

  CepModel({
    this.cep,
    this.road,
    this.complement,
    this.unity,
    this.neighborhood,
    this.city,
    this.state,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'cep': cep,
      'logradouro': road,
      'complemento': complement,
      'unidade': unity,
      'bairro': neighborhood,
      'localidade': city,
      'uf': state,
      'ibge': ibge,
      'gia': gia,
      'ddd': ddd,
      'siafi': siafi,
    };

    map.removeWhere((key, value) => value == null || value.isEmpty);

    return map;
  }

  factory CepModel.fromMap(Map<String, dynamic> map) {
    return CepModel(
      cep: map['cep'] != null ? map['cep'] as String : null,
      road: map['logradouro'] != null ? map['logradouro'] as String : null,
      complement:
          map['complemento'] != null ? map['complemento'] as String : null,
      unity: map['unidade'] != null ? map['unidade'] as String : null,
      neighborhood: map['bairro'] != null ? map['bairro'] as String : null,
      city: map['localidade'] != null ? map['localidade'] as String : null,
      state: map['uf'] != null ? map['uf'] as String : null,
      ibge: map['ibge'] != null ? map['ibge'] as String : null,
      gia: map['gia'] != null ? map['gia'] as String : null,
      ddd: map['ddd'] != null ? map['ddd'] as String : null,
      siafi: map['siafi'] != null ? map['siafi'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CepModel.fromJson(String source) =>
      CepModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
