import 'package:challenge_uex/app/core/services/initialize_dio.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

import 'package:challenge_uex/app/core/database/database.dart';
import 'package:challenge_uex/app/core/error/error.dart';
import 'package:challenge_uex/app/core/interfaces/interfaces.dart';
import 'package:challenge_uex/app/core/models/models.dart';

class ContactRepository implements IContact {
  final HiveService hiveService;
  final Dio _dio;

  ContactRepository(
    this._dio, {
    required this.hiveService,
  }) {
    InitializeDio.initializeDioOptions(_dio);
  }

  @override
  Future<void> createContact({required ContactModel contact}) async {
    try {
      await hiveService.createContact(contact: contact);
    } catch (e) {
      log(e.toString());
      if (e == RequestError.invalidData) {
        throw 'Já existe um usuário cadastrado com este CPF.';
      } else {
        throw 'Erro ao criar contato.';
      }
    }
  }

  @override
  Future<void> updateContact(
      {required ContactModel contact, required String email}) async {
    try {
      await hiveService.updateContact(contact: contact, email: email);
    } catch (e) {
      log(e.toString());
      if (e == RequestError.notFound) {
        throw 'Contato não encontrado para edição.';
      } else if (e == RequestError.invalidData) {
        throw 'Você não pode editar um contato que não foi criado por você.';
      } else {
        throw 'Erro ao editar o contato.';
      }
    }
  }

  @override
  Future<List<ContactModel>?> getContactsCreatedByUser(
      {required String email}) async {
    try {
      final result = await hiveService.getContactsCreatedByUser(
          contactCreatorEmail: email);

      return result;
    } catch (e) {
      log(e.toString());
      throw 'Erro ao obter contatos criados.';
    }
  }

  @override
  Future<void> deleteContactCreatedByUser({required String cpf}) async {
    try {
      await hiveService.deleteContactCreatedByUser(cpf: cpf);
    } catch (e) {
      log(e.toString());
      throw 'Erro ao excluir contato.';
    }
  }

  @override
  Future<void> deleteAllContactsCreatedByUser({required String email}) async {
    try {
      await hiveService.deleteAllContactsCreatedByUser(
          contactCreatorEmail: email);
    } catch (e) {
      log(e.toString());
      throw 'Erro ao excluir contatos.';
    }
  }

  @override
  Future<CepModel> getAddressWithCep(String cep) async {
    try {
      final result = await _dio.getUri<Map<String, dynamic>>(
          Uri.parse('https://viacep.com.br/ws/$cep/json/'));

      return CepModel.fromMap(result.data ?? {});
    } catch (e) {
      log(e.toString());
      throw 'Erro ao buscar endereço pelo CEP';
    }
  }

  @override
  Future<List<CepModel>> getAddressSuggestions({
    required String state,
    required String city,
    required String address,
  }) async {
    try {
      final result = await _dio.getUri(
          Uri.parse('https://viacep.com.br/ws/$state/$city/$address/json/'));

      final addressSuggestions = List.generate(
        result.data.length,
        (index) => CepModel.fromMap(result.data[index]),
      );

      return addressSuggestions;
    } catch (e) {
      log(e.toString());
      throw 'Erro ao buscar sugestões de endereço';
    }
  }

  @override
  Future<Map<String, dynamic>> getCoordinatesFromAddress(String query) async {
    String mapsKey = const String.fromEnvironment('mapsApiKey');

    try {
      final result = await _dio.getUri(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=geometry&input=$query&inputtype=textquery&key=$mapsKey'),
        options: Options(
          headers: {
            'Access-Control-Allow-Origin': '*',
          },
        ),
      );

      if (result.data['status'] == 'ZERO_RESULTS') {
        throw RequestError.notFound;
      }

      return {
        'lat': result.data?['candidates']?[0]['geometry']['location']['lat'],
        'long': result.data?['candidates']?[0]['geometry']['location']['lng'],
      };
    } catch (e) {
      log(e.toString());
      if (e == RequestError.notFound) {
        throw 'Não foram encontradas as coordenadas do endereço. Insira mais informações e tente novamente';
      } else {
        throw 'Erro ao obter coordenadas do endereço';
      }
    }
  }
}
