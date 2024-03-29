import 'package:mobile/data/models/wiki_tag.dart';

class InterestArea {
  final int id;
  final int? creatorId;
  final String accessLevel;
  final String name;
  final List<WikiTag> wikiTags;
  final DateTime createTime;
  final String description;
  final String? pictureUrl;

  InterestArea({
    required this.id,
    required this.creatorId,
    required this.accessLevel,
    required this.name,
    required this.wikiTags,
    required this.createTime,
    required this.description,
    this.pictureUrl,
  });

  factory InterestArea.fromJson(Map<String, dynamic> json) {
    List<dynamic> wikiTagsJson = json['wikiTags'] ?? [];
    List<WikiTag> parsedWikiTags =
        wikiTagsJson.map((tag) => WikiTag.fromJson(tag)).toList();

    return InterestArea(
      id: json['id'] ?? 0,
      pictureUrl: json['pictureUrl'],
      creatorId: json['creatorId'],
      accessLevel: json['accessLevel'] ?? '',
      name: json['title'] ?? '',
      wikiTags: parsedWikiTags,
      createTime: DateTime.parse(json['createTime'] ?? ''),
      description: json['description'] ?? '',
    );
  }

  get accessInt {
    switch (accessLevel) {
      case 'PUBLIC':
        return 0;
      case 'PRIVATE':
        return 1;
      case 'PERSONEL':
        return 2;
      default:
        return 0;
    }
  }
}
