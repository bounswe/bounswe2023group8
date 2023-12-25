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
    var uri = Uri.parse(target);

    return AnnotationModel(
      id: json['id'],
      note: uri.queryParameters['comment'] ?? '',
      start: int.parse(json['body']['value'].split('-').first),
      end: int.parse(json['body']['value'].split('-').last),
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
