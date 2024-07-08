import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContactModel {
  String? contactName;
  String? contactCreatorEmail;
  String? phone;
  String? cpf;
  String? cep;
  String? address;
  String? complement;
  String? number;
  String? neighborhood;
  String? city;
  String? state;
  double? lat;
  double? long;

  ContactModel({
    this.contactName,
    this.contactCreatorEmail,
    this.phone,
    this.cpf,
    this.cep,
    this.address,
    this.complement,
    this.number,
    this.neighborhood,
    this.city,
    this.state,
    this.lat,
    this.long,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'contactName': contactName,
      'contactCreatorEmail': contactCreatorEmail,
      'phone': phone,
      'cpf': cpf,
      'cep': cep,
      'address': address,
      'complement': complement,
      'number': number,
      'neighborhood': neighborhood,
      'city': city,
      'state': state,
      'lat': lat,
      'long': long,
    };

    map.removeWhere((key, value) => value == null);

    return map;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      contactName:
          map['contactName'] != null ? map['contactName'] as String : null,
      contactCreatorEmail: map['contactCreatorEmail'] != null ? map['contactCreatorEmail'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      cep: map['cep'] != null ? map['cep'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      complement:
          map['complement'] != null ? map['complement'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      neighborhood:
          map['neighborhood'] != null ? map['neighborhood'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      lat: map['lat'] != null ? map['lat'] as double : null,
      long: map['long'] != null ? map['long'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
