import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/geolocation_model.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/wiki_tag.dart';

class Spot {
  final int id;
  final EnigmaUser enigmaUser;
  final InterestArea interestArea;
  final String sourceLink;
  final String title;
  final List<WikiTag> wikiTags;
  final String label;
  final String content;
  final Geolocation geolocation;
  final String createTime;
  final int upvoteCount;
  final int downvoteCount;
  final int commentCount;

  Spot({
    required this.id,
    required this.enigmaUser,
    required this.interestArea,
    required this.sourceLink,
    required this.title,
    required this.wikiTags,
    required this.label,
    required this.content,
    required this.geolocation,
    required this.createTime,
    required this.upvoteCount,
    required this.downvoteCount,
    required this.commentCount,
  });

  factory Spot.fromJson(Map<String, dynamic> json) {
    return Spot(
        id: json['id'],
        enigmaUser: EnigmaUser.fromJson(json['enigmaUser']),
        interestArea: InterestArea.fromJson(json['interestArea']),
        sourceLink: json['sourceLink'],
        title: json['title'],
        wikiTags: (json['wikiTags'] as List)
            .map((tag) => WikiTag.fromJson(tag))
            .toList(),
        label: json['label'],
        content: json['content'],
        geolocation: Geolocation.fromJson(json['geolocation']),
        upvoteCount: json['upvoteCount'] ?? 0,
        downvoteCount: json['downvoteCount'] ?? 0,
        commentCount: json['commentCount'] ?? 0,
        createTime: json['createTime'] != null
            ? '${json['createTime'].toString().substring(8, 10)}.${json['createTime'].toString().substring(5, 7)}.${json['createTime'].toString().substring(0, 4)} ${json['createTime'].toString().substring(11, 16)}'
            : '');
  }
}
