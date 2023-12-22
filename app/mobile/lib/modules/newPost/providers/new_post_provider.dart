import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/wiki_tag.dart';

import '../../../data/constants/config.dart';
import '../../../data/models/custom_exception.dart';

class NewPostProvider extends GetConnect {
  @override
  void onInit() {
    timeout = const Duration(seconds: 30);
    httpClient.defaultDecoder = (map) {};
    httpClient.baseUrl = Config.baseUrl;
  }

  Future<bool> createNewPost(
      {required String title,
      required String sourceLink,
      required int interestAreaId,
      required int label,
      required String content,
      required List<String> tags,
      required double latitude,
      required double longitude,
      required bool isAgeRestricted,
      required String address,
      required String token}) async {
    final response = await post('v1/post', {
      "interestAreaId": interestAreaId,
      "sourceLink": sourceLink,
      "title": title,
      "wikiTags": tags,
      "isAgeRestricted": isAgeRestricted,
      "label": label,
      "content": content,
      "geoLocation": {
        "latitude": latitude,
        "longitude": longitude,
        "address": address
      }
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
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



  Future<List<InterestArea>?> getIas(
      {required int id, required String token}) async {
    final response = await get('v1/user/$id/interest-areas', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        return (body as List)
            .map((e) => InterestArea.fromJson(e))
            .toList();
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
