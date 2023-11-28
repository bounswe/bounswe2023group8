class PostModel {
  final int id;
  final int userId;
  final List<int> iaIds;
  final String sourceLink;
  final String content;
  final String createdAt;
  final String title;

  const PostModel({
    required this.id,
    required this.userId,
    required this.iaIds,
    required this.sourceLink,
    required this.content,
    required this.createdAt,
    required this.title,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['user_id'],
      iaIds: json['ia_ids'].cast<int>(),
      sourceLink: json['source_link'],
      content: json['content'],
      createdAt: json['created_at'],
      title: json['title'],
    );
  }
}
