import 'package:challenge_uex/app/core/models/models.dart';

abstract class IContact {
  ///Create new contact
  Future<void> createContact({required ContactModel contact});

  ///Update contact
  Future<void> updateContact(
      {required ContactModel contact, required String email});

  ///Get contacts created by user
  Future<List<ContactModel>?> getContactsCreatedByUser({required String email});

  ///Delete user created contact
  Future<void> deleteContactCreatedByUser({required String cpf});

  ///Delete all user created contacts
  Future<void> deleteAllContactsCreatedByUser({required String email});

  ///Get addres with zip code
  Future<CepModel> getAddressWithCep(String cep);

  ///Get suggestions of address
  Future<List<CepModel>> getAddressSuggestions({
    required String state,
    required String city,
    required String address,
  });

  ///Get coordinates from address
  Future<Map<String, dynamic>> getCoordinatesFromAddress(String query);
}
