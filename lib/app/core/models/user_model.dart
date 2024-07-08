import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? email;
  String? name;
  String? password;

  UserModel({
    this.email,
    this.name,
    this.password,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'email': email,
      'name': name,
      'password': password,
    };

    map.removeWhere((key, value) => value == null);

    return map;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
