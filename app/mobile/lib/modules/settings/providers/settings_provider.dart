import 'dart:convert';
import 'dart:developer';

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
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return true;
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }

    return false;
  }

  Future<bool> changePassword(
      {required String token,
      required String oldPassword,
      required String newPassword1,
      required String newPassword2,
      required int engimaUserId}) async {
    final response = await post('auth/change-password', {
      'oldPassword': oldPassword,
      'newPassword1': newPassword1,
      'newPassword2': newPassword2,
    }, query: {
      'enigmaUserId': engimaUserId.toString()
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return true;
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }

    return false;
  }

  Future<bool> deleteUser({required String token, required int id}) async {
    final response = await delete('v1/user/$id', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
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
