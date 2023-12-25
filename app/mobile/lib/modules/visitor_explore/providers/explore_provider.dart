import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';

import '../../../data/constants/config.dart';
import '../../../data/models/custom_exception.dart';

class ExploreProvider extends GetConnect {
  @override
  void onInit() {
    timeout = const Duration(seconds: 30);
    httpClient.defaultDecoder = (map) {};
    httpClient.baseUrl = Config.baseUrl;
  }

  Future<List<Spot>?> getExploreSpots() async {
    final response = await get(
      'v1/explore',
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        final posts = body['posts'] as List;
        return posts.map((e) => Spot.fromJson(e)).toList();
      }
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }

    return null;
  }

  Future<List<EnigmaUser>?> getExploreProfiles() async {
    final response = await get(
      'v1/explore',
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        final profiles = body['enigmaUsers'] as List;
        return profiles.map((e) => EnigmaUser.fromJson(e)).toList();
      }
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }

    return null;
  }

  Future<List<InterestArea>?> getExploreBunches() async {
    final response = await get(
      'v1/explore',
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        final bunches = body['interestAreas'] as List;
        return bunches.map((e) => InterestArea.fromJson(e)).toList();
      }
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }

    return null;
  }

  // Navigate to sign up page
}
