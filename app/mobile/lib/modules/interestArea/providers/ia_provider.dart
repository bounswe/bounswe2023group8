import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/modules/interestArea/models/ia_request.dart';

import '../../../data/constants/config.dart';
import '../../../data/models/custom_exception.dart';

class IaProvider extends GetConnect {
  @override
  void onInit() {
    timeout = const Duration(seconds: 30);
    httpClient.defaultDecoder = (map) {};
    httpClient.baseUrl = Config.baseUrl;
  }

  Future<InterestArea?> getIa({required int id, required String token}) async {
    final response = await get('v1/interest-area', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, query: {
      'id': id.toString(),
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        return InterestArea.fromJson(body);
      }
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }

    return null;
  }

  Future<List<EnigmaUser>?> getFollowers(
      {required int id, required String token}) async {
    final response = await get('v1/interest-area/$id/followers', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        return (body as List).map((e) => EnigmaUser.fromJson(e)).toList();
      }
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return null;
  }

  Future<List<Spot>?> getPosts({required int id, required String token}) async {
    final response = await get('v1/interest-area/$id/posts', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        return (body as List).map((e) => Spot.fromJson(e)).toList();
      }
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return null;
  }

  Future<List<InterestArea>?> getNestedIas(
      {required int id, required String token}) async {
    final response =
        await get('v1/interest-area/$id/nested-interest-areas', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        return (body as List).map((e) => InterestArea.fromJson(e)).toList();
      }
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return null;
  }

  Future<List<InterestArea>?> searchIas(
      {required String key, required String token}) async {
    final response = await get('v1/interest-area/search', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, query: {
      'searchKey': key,
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!) as List;
        return body.map((e) => InterestArea.fromJson(e)).toList();
      }
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return null;
  }

  Future<bool> followIa({required int id, required String token}) async {
    final response = await get('v1/interest-area/follow', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, query: {
      'id': id.toString(),
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

  Future<bool> unfollowIa({required int id, required String token}) async {
    final response = await get('v1/interest-area/unfollow', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, query: {
      'id': id.toString(),
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

  Future<bool> report(
      {required int entityId,
      required String entityType,
      required String reason,
      required String token}) async {
    final response = await post('v1/moderation/report', {
      'entityId': entityId,
      'entityType': entityType,
      'reason': reason,
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

  Future<List<IaRequest>?> getIaRequests(
      {required int id, required String token}) async {
    final response =
        await get('v1/interest-area/$id/follow-requests', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!) as List;
        return body.map((e) => IaRequest.fromJson(e)).toList();
      }
    } else {
      if (response.bodyString != null && response.bodyString!.isNotEmpty) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return null;
  }

  Future<bool> acceptIaRequest(
      {required int requestId, required String token}) async {
    final response =
        await get('v1/interest-area/accept-follow-request', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, query: {
      'requestId': requestId.toString(),
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return true;
    } else {
      if (response.bodyString != null && response.bodyString!.isNotEmpty) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return false;
  }

  Future<bool> rejectIaRequest(
      {required int requestId, required String token}) async {
    final response =
        await get('v1/interest-area/reject-follow-request', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, query: {
      'requestId': requestId.toString(),
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    }
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return true;
    } else {
      if (response.bodyString != null && response.bodyString!.isNotEmpty) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return false;
  }
}
