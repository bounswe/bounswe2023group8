import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/constants/config.dart';
import '../../../data/models/custom_exception.dart';

class OpeningProvider extends GetConnect {
  @override
  void onInit() {
    timeout = const Duration(seconds: 30);
    httpClient.defaultDecoder = (map) {};
    httpClient.baseUrl = Config.baseUrl;
  }

  Future<Map<String, dynamic>?> login(
      {required String user, required String password}) async {
    final response = await get('auth/signin', query: {
      'user': user,
      'password': password,
    });

    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        return {
          'token': body['authentication']['accessToken'],
          'userId': body['userId'],
        };
      }
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }

    return null;
  }
}
