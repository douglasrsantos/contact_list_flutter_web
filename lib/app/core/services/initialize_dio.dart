import 'package:dio/dio.dart';

class InitializeDio {
  static initializeDioOptions(
    Dio client, {
    int? receiveTimeoutSeconds,
    int? connectTimeoutSeconds,
  }) async {
    client.options = BaseOptions(
      contentType: 'application/json',
      receiveTimeout: Duration(seconds: receiveTimeoutSeconds ?? 60),
      connectTimeout: Duration(seconds: connectTimeoutSeconds ?? 60),
    );
  }
}
