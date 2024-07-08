import 'package:hive_flutter/hive_flutter.dart';

import 'package:challenge_uex/app/core/error/error.dart';
import 'package:challenge_uex/app/core/models/models.dart';

class HiveService {
  BoxCollection? collection;

  HiveService() {
    _init();
  }

  _init() async {
    collection = await BoxCollection.open(
      'CHALLENGE_UEX',
      {'users', 'contacts', 'login'},
      path: './',
    );
  }

  //Create new user
  Future<void> createUser({required UserModel user}) async {
    var box = await collection!.openBox('users');

    final emailsRegistered = await box.getAllKeys();

    for (String email in emailsRegistered) {
      if (email == user.email!) {
        throw RequestError.unauthorized;
      }
    }

    await box.put(user.email!, user.toMap());
  }

  ///Search user by email
  Future<Map<String, dynamic>> getUserByEmail({required String email}) async {
    var box = await collection!.openBox('users');

    final result = await box.get(email);

    if (result == null) {
      throw RequestError.notFound;
    } else {
      return Map<String, dynamic>.from(result);
    }
  }

  ///Search all users
  Future<Map<String, dynamic>?> getAllUsers() async {
    var box = await collection!.openBox('users');

    final users = await box.getAllValues();

    return users;
  }

  ///Get the email of the user who is loged in
  Future<String?> getUserEmail() async {
    var box = await collection!.openBox('login');

    final result = await box.getAllValues();

    if (result.isEmpty) {
      throw RequestError.notFound;
    } else {
      return result['contactCreatorEmail'];
    }
  }

  ///Saves the email of the user who logged in
  Future<void> saveUserEmail(String email) async {
    var box = await collection!.openBox('login');

    await box.put('email', email);
  }

  ///Logout
  Future<void> clearUserEmail() async {
    var box = await collection!.openBox('login');

    await box.clear();
  }

  ///Delete User Account
  Future<void> deleteAccount(
      {required String email, required String password}) async {
    var boxLogin = await collection!.openBox('login');
    var boxUsers = await collection!.openBox('users');

    final user = await getUserByEmail(email: email);

    if (user.isEmpty || user['password'] != password) {
      throw RequestError.unauthorized;
    }

    await deleteAllContactsCreatedByUser(contactCreatorEmail: email);

    await boxLogin.clear();
    await boxUsers.delete(email);
  }

  ///Get all contacts
  Future<Map<String, dynamic>?> getAllContacts() async {
    var box = await collection!.openBox('contacts');

    final contacts = await box.getAllValues();

    return contacts;
  }

  ///Create new contact
  Future<void> createContact({required ContactModel contact}) async {
    var box = await collection!.openBox('contacts');

    final contactsCreated = await box.getAllKeys();

    if (contactsCreated.isNotEmpty) {
      for (String cpf in contactsCreated) {
        if (cpf == contact.cpf) {
          throw RequestError.invalidData;
        }
      }
    }

    await box.put(contact.cpf ?? '', contact.toMap());
  }

  ///Update contact
  Future<void> updateContact(
      {required ContactModel contact, required String email}) async {
    var box = await collection!.openBox('contacts');

    final allContacts = await box.getAllValues();

    if (!allContacts.containsKey(contact.cpf)) {
      throw RequestError.notFound;
    }

    allContacts.removeWhere((key, value) => key == contact.cpf);

    await box.clear();

    if (allContacts.isEmpty) {
      await box.put(
          contact.cpf ?? '', Map<String, dynamic>.from(contact.toMap()));
    } else {
      allContacts[contact.cpf ?? ''] =
          Map<String, dynamic>.from(contact.toMap());
      allContacts.forEach(
        (key, value) async {
          await box.put(key, value);
        },
      );
    }
  }

  ///Get contacts created by user
  Future<List<ContactModel>?> getContactsCreatedByUser(
      {required String contactCreatorEmail}) async {
    Map<String, dynamic> userCreatedContacts = {};

    var box = await collection!.openBox('contacts');

    final allContacts = await box.getAllValues();

    allContacts.forEach(
      (key, value) {
        if (value['contactCreatorEmail'] == contactCreatorEmail) {
          userCreatedContacts[key] = Map<String, dynamic>.from(value);
        }
      },
    );

    // ignore: unnecessary_null_comparison
    if (userCreatedContacts != null && userCreatedContacts.isNotEmpty) {
      final contacts = userCreatedContacts.values
          .map(
            (contact) => ContactModel.fromMap(contact),
          )
          .toList();

      return contacts;
    }

    return null;
  }

  ///Delete user created contact
  Future<void> deleteContactCreatedByUser({required String cpf}) async {
    var box = await collection!.openBox('contacts');

    await box.delete(cpf);
  }

  ///Delete all user created contacts
  Future<void> deleteAllContactsCreatedByUser(
      {required String contactCreatorEmail}) async {
    var box = await collection!.openBox('contacts');

    final allContacts = await box.getAllValues();

    if (allContacts.isEmpty) {
      return;
    }

    allContacts.forEach(
      (key, value) async {
        if (value['contactCreatorEmail'] == contactCreatorEmail) {
          await box.delete(key);
        }
      },
    );
  }
}
