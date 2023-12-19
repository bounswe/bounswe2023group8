import 'package:mobile/data/models/enigma_user.dart';

class CommentModel {
  final int id;
  final int postId;
  final EnigmaUser enigmaUser;
  final String content;
  final DateTime createTime;

  CommentModel({
    required this.id,
    required this.postId,
    required this.enigmaUser,
    required this.content,
    required this.createTime,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      postId: json['postId'],
      enigmaUser: EnigmaUser.fromJson(json['enigmaUser']),
      content: json['content'],
      createTime: DateTime.parse(json['createTime']),
    );
  }
}
