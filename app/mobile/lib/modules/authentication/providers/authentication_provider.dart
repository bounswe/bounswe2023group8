import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/constants/config.dart';
import '../../../data/models/custom_exception.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    timeout = const Duration(seconds: 30);
    httpClient.defaultDecoder = (map) {};
    httpClient.baseUrl = Config.baseUrl;
  }

  Future<bool> signUp(
      {required String username,
      required String email,
      required String password,
      required String birthday}) async {
    final response = await post('auth/signup', {
      'username': username,
      'email': email,
      'password': password,
      'birthday': birthday
    }, headers: {
      'Accept': 'application/json',
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

  Future<Map<String, dynamic>?> login(
      {required String user, required String password}) async {
    final response = await get('auth/signin', query: {
      'user': user,
      'password': password,
    });

    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<bool> forgotPassword({required String email}) async {
    final response = await get('auth/forgot-password', headers: {
      'Accept': 'application/json',
    }, query: {
      'email': email,
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

  Future<bool> resetPassword(
      {required String email,
      required String password,
      required String token,
      required String passwordConfirmation}) async {
    final response = await post('auth/reset-password', {
      'email': email,
      'password': password,
      'token': token,
      'password_confirmation': passwordConfirmation
    }, headers: {
      'Accept': 'application/json',
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
