class AppUser {
  final int id;
  final String username;
  final String name;
  final String email;
  final String birthday;
  final String createTime;
  final String? pictureUrl;

  AppUser({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.birthday,
    required this.createTime,
    this.pictureUrl,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      birthday: json['birthday'],
      createTime: json['createTime'],
      pictureUrl: json['pictureUrl'],
    );
  }
}
