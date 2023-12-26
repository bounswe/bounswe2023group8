import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';

import '../../../data/constants/config.dart';
import '../../../data/models/custom_exception.dart';

class HomeProvider extends GetConnect {
  @override
  void onInit() {
    timeout = const Duration(seconds: 30);
    httpClient.defaultDecoder = (map) {};
    httpClient.baseUrl = Config.baseUrl;
  }

  Future<List<Spot>?> getHomePage({required String token}) async {
    final response = await get('v1/home', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
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

  Future<Map<String, dynamic>?> globalSearch(
      {required String token, required String searchKey}) async {
    final response = await get('v1/search', query: {
      'searchKey': searchKey
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        final posts = (body['posts'] ?? []) as List;
        final users = (body['users'] ?? []) as List;
        final ias = (body['interestAreas'] ?? []) as List;
        return {
          'posts': posts.map((e) => Spot.fromJson(e)).toList(),
          'users': users.map((e) => EnigmaUser.fromJson(e)).toList(),
          'interestAreas': ias.map((e) => InterestArea.fromJson(e)).toList(),
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

  Future<bool> downvotePost(
      {required String token, required int postId}) async {
    final response = await get('v1/post/downvote', query: {
      'id': postId.toString(),
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

  Future<bool> upvotePost({required String token, required int postId}) async {
    final response = await get('v1/post/upvote', query: {
      'id': postId.toString(),
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

  Future<bool> unvotePost({required String token, required int postId}) async {
    final response = await get('v1/post/unvote', query: {
      'id': postId.toString(),
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

  Future<bool> hasUpVoted(
      {required String token, required int postId, required int userId}) async {
    final response = await get('v1/post/$postId/votes', query: {
      'id': postId.toString(),
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      final body = json.decode(response.bodyString!) as List;
      for (final vote in body) {
        if (vote['enigmaUser']['id'] == userId) {
          return vote['isUpvote'];
        }
      }
      return false;
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return false;
  }

  Future<bool> hasDownVoted(
      {required String token, required int postId, required int userId}) async {
    final response = await get('v1/post/$postId/votes', query: {
      'id': postId.toString(),
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      final body = json.decode(response.bodyString!) as List;
      for (final vote in body) {
        if (vote['enigmaUser']['id'] == userId) {
          return !vote['isUpvote'];
        }
      }
      return false;
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return false;
  }

  Future<List<EnigmaUser>> getDownvotedUsers(
      {required String token, required int postId}) async {
    final response = await get('v1/post/$postId/votes', query: {
      'id': postId.toString(),
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!) as List;
        final downvotedUsers = <EnigmaUser>[];
        for (final vote in body) {
          if (!vote['isUpvote']) {
            downvotedUsers.add(EnigmaUser.fromJson(vote['enigmaUser']));
          }
        }
        return downvotedUsers;
      }
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      } else {
        throw CustomException('Error', 'Something went wrong');
      }
    }
    return [];
  }

  Future<List<EnigmaUser>> getUpvotedUsers(
      {required String token, required int postId}) async {
    final response = await get('v1/post/$postId/votes', query: {
      'id': postId.toString(),
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!) as List;
        final upvotedUsers = <EnigmaUser>[];
        for (final vote in body) {
          if (vote['isUpvote']) {
            upvotedUsers.add(EnigmaUser.fromJson(vote['enigmaUser']));
          }
        }
        return upvotedUsers;
      }
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      } else {
        throw CustomException('Error', 'Something went wrong');
      }
    }
    return [];
  }
}
