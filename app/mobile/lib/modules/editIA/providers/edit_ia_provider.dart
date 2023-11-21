import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile/data/models/wiki_tag.dart';

import '../../../data/constants/config.dart';
import '../../../data/models/custom_exception.dart';

class EditIaProvider extends GetConnect {
  @override
  void onInit() {
    timeout = const Duration(seconds: 30);
    httpClient.defaultDecoder = (map) {};
    httpClient.baseUrl = Config.baseUrl;
  }

  Future<bool> updateIa(
      {required String name,
      required List<String> nestedIas,
      required List<String> wikiTags,
      required int accessLevel,
      required String description,
      required int id,
      required String token}) async {
    final response = await put('v1/interest-area', {
      'name': name,
      'nestedInterestAreas': nestedIas,
      'wikiTags': wikiTags,
      'accessLevel': accessLevel,
      // TODO: Add description to the request
      //'description': description
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, query: {
      'id': id.toString(),
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

  Future<bool> deleteIa({required int id, required String token}) async {
    final response = await delete('v1/interest-area', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, query: {
      'id': id.toString(),
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

  Future<List<WikiTag>?> searchTags(
      {required String key, required String token}) async {
    final response = await get('v1/wiki/search', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, query: {
      'searchKey': key,
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!) as List;
        return body.map((e) => WikiTag.fromWikiResponse(e)).toList();
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
