import 'dart:developer';

class AnnotationModel {
  String id;
  int start;
  int end;
  String note;

  int userId;
  String name;
  String? profilePhoto;
  String username;

  AnnotationModel({
    required this.id,
    required this.start,
    required this.end,
    required this.note,
    required this.userId,
    required this.name,
    this.profilePhoto,
    required this.username,
  });

  factory AnnotationModel.fromJson(Map<String, dynamic> json) {
    String target = json['target'];
    log(target);
    var uri = Uri.parse(target);

    // sort and make start smaller
    final first = int.parse(json['body']['value'].split('-').first);
    final second = int.parse(json['body']['value'].split('-').last);

    final start = first < second ? first : second;
    final end = first > second ? first : second;


    return AnnotationModel(
      id: json['id'],
      note: uri.queryParameters['comment'] ?? '',
      start: start,
      end: end,
      userId: uri.queryParameters['userId'] != null
          ? int.parse(uri.queryParameters['userId'] ?? '')
          : 0,
      name: uri.queryParameters['name'] ?? '',
      profilePhoto: uri.queryParameters['profilePhoto'] == ''
          ? null
          : uri.queryParameters['profilePhoto'],
      username: uri.queryParameters['username'] ?? '',
    );
  }
}
