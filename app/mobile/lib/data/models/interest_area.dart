import 'package:mobile/data/models/wiki_tag.dart';

class InterestArea {
  final int id;
  final int enigmaUserId;
  final String accessLevel;
  final String name;
  final List<String> nestedInterestAreas;
  final List<WikiTag> wikiTags;
  final DateTime createTime;

  InterestArea({
    required this.id,
    required this.enigmaUserId,
    required this.accessLevel,
    required this.name,
    required this.nestedInterestAreas,
    required this.wikiTags,
    required this.createTime,
  });

  factory InterestArea.fromJson(Map<String, dynamic> json) {
    List<dynamic> wikiTagsJson = json['wikiTags'] ?? [];
    List<WikiTag> parsedWikiTags =
        wikiTagsJson.map((tag) => WikiTag.fromJson(tag)).toList();

    return InterestArea(
      id: json['id'] ?? 0,
      enigmaUserId: json['enigmaUserId'] ?? 0,
      accessLevel: json['accessLevel'] ?? '',
      name: json['name'] ?? '',
      nestedInterestAreas: List<String>.from(json['nestedInterestAreas'] ?? []),
      wikiTags: parsedWikiTags,
      createTime: DateTime.parse(json['createTime'] ?? ''),
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
