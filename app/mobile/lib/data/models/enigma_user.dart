class EnigmaUser {
  final int id;
  final String username;
  final String name;
  final String email;
  final String birthday;
  final String createTime;
  final String? pictureUrl;

  EnigmaUser({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.birthday,
    required this.createTime,
    this.pictureUrl,
  });

  factory EnigmaUser.fromJson(Map<String, dynamic> json) {
    return EnigmaUser(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      birthday: json['birthday'],
      pictureUrl: json['pictureUrl'],
      createTime: json['createTime'] != null
          ? '${json['createTime'].toString().substring(8, 10)}.${json['createTime'].toString().substring(5, 7)}.${json['createTime'].toString().substring(0, 4)} ${json['createTime'].toString().substring(11, 16)}'
          : '',
    );
  }
}
