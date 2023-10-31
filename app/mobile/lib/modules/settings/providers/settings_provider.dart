import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/constants/config.dart';
import '../../../data/models/custom_exception.dart';

class SettingsProvider extends GetConnect {
  @override
  void onInit() {
    timeout = const Duration(seconds: 30);
    httpClient.defaultDecoder = (map) {};
    httpClient.baseUrl = Config.baseUrl;
  }

  Future<bool> logout({required String token}) async {
    final response = await post('auth/logout', {}, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }

    return false;
  }
}
