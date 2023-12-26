import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile/data/models/annotation_mode.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/data/models/tag_suggestion.dart';
import 'package:mobile/data/models/wiki_tag.dart';
import 'package:mobile/modules/post_details/models/comment.dart';

import '../../../data/constants/config.dart';
import '../../../data/models/custom_exception.dart';

class PostDetailsProvider extends GetConnect {
  @override
  void onInit() {
    timeout = const Duration(seconds: 30);
    httpClient.defaultDecoder = (map) {};
    httpClient.baseUrl = Config.baseUrl;
  }

  Future<bool> followUser({required int id, required String token}) async {
    final response = await get('v1/user/follow', headers: {
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

  Future<bool> unfollowUser({required int id, required String token}) async {
    final response = await get('v1/user/unfollow', headers: {
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

  Future<Spot?> getPostById({required int id, required String token}) async {
    final response = await get('v1/post', headers: {
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
        return Spot.fromJson(body);
      }
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return null;
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

  Future<List<CommentModel>?> getPostComments(
      {required int postId, required String token}) async {
    final response = await get('v1/post/$postId/comments', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode == 201 || response.statusCode == 200) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!) as List;
        return body.map((e) => CommentModel.fromJson(e)).toList();
      }
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return null;
  }

  Future<bool> comment(
      {required int postId,
      required String content,
      required String token}) async {
    final response = await post('v1/post/$postId/comment', {
      'content': content,
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return false;
  }

  Future<bool> deleteComment(
      {required int commentId,
      required String token,
      required int postId}) async {
    final response =
        await delete('v1/post/$postId/comment/$commentId', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    }
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return true;
    } else {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return false;
  }

  Future<bool> suggestTag(
      {required String token,
      required List<String> tags,
      required int entityId,
      required String entityType}) async {
    final response = await post('v1/tag-suggestion', {
      'tags': tags,
      'entityId': entityId,
      'entityType': entityType,
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
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
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

  Future<List<TagSuggestion>?> getTagSuggestions(
      {required int entityId,
      required String entityType,
      required String token}) async {
    final response = await get('v1/tag-suggestion', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, query: {
      'entityId': entityId.toString(),
      'entityType': entityType,
    });
    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null) {
        final body = json.decode(response.bodyString!) as List;
        return body.map((e) => TagSuggestion.fromJson(e)).toList();
      }
    } else {
      if (response.bodyString != null && response.bodyString!.isNotEmpty) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return null;
  }

  Future<bool> acceptTagSuggestion(
      {required int tagSuggestionId, required String token}) async {
    final response = await get('v1/tag-suggestion/accept', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, query: {
      'tagSuggestionId': tagSuggestionId.toString(),
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

  Future<bool> rejectTagSuggestion(
      {required int tagSuggestionId, required String token}) async {
    final response = await get('v1/tag-suggestion/reject', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, query: {
      'tagSuggestionId': tagSuggestionId.toString(),
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

  Future<bool> createAnnotationContainer(
      {required String token, required int postId}) async {
    httpClient.baseUrl = 'http://18.192.100.93:80/wia';
    final response = await post('', {
      'name': 'post-$postId',
      'label': 'post-$postId',
      "type": ["BasicContainer", "AnnotationCollection"],
    }, headers: {
      'Accept': 'application/ld+json',
      'Content-Type': 'application/ld+json'
    });
    httpClient.baseUrl = Config.baseUrl;

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

  Future<bool> createAnnotation(
      {required String token,
      required int postId,
      required String comment,
      required String text,
      required EnigmaUser user}) async {
    httpClient.baseUrl = 'http://18.192.100.93:80/wia';
    final response = await post('/post-$postId', {
      "type": "Annotation",
      "body": {"type": "TextualBody", "value": text, "name": 'annotation'},
      "target":
          "http://bunchup.com.tr/post/$postId?userId=${user.id}&name=${user.name}&profilePhoto=${user.pictureUrl ?? ''}&username=${user.username}&comment=$comment",
    }, headers: {
      'Accept': 'application/ld+json',
      'Content-Type': 'application/ld+json'
    });
    httpClient.baseUrl = Config.baseUrl;

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

  Future<List<AnnotationModel>?> getAnnotations(
      {required String token, required int postId}) async {
    httpClient.baseUrl = 'http://18.192.100.93:80/wia';
    final response = await get('/post-$postId', headers: {
      'Accept': 'application/ld+json',
      'Content-Type': 'application/ld+json'
    });
    httpClient.baseUrl = Config.baseUrl;

    if (response.statusCode == null) {
      throw CustomException(
          'Error', response.statusText ?? 'The connection has timed out.');
    }
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.bodyString != null && response.bodyString!.isNotEmpty) {
        final body = json.decode(response.bodyString!);
        final items = (body['first']['items'] as List)
            .map((e) => AnnotationModel.fromJson(e))
            .toList();

        return items;
      }
    } else {
      if (response.bodyString != null && response.bodyString!.isNotEmpty) {
        final body = json.decode(response.bodyString!);
        throw CustomException.fromJson(body);
      }
    }
    return null;
  }

  Future<bool> deleteAnnotation(
      {required String token,
      required int postId,
      required String annotationId}) async {
    httpClient.baseUrl = 'http://18.192.100.93:80/wia';
    final id = annotationId.split('/').last;
    final response = await delete('/post-$postId/$id', headers: {
      'Accept': 'application/ld+json',
      'Content-Type': 'application/ld+json'
    });
    httpClient.baseUrl = Config.baseUrl;

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
