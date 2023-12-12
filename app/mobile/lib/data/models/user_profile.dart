class UserProfile {
  final int id;
  final String username;
  final String name;
  final String birthday;
  final int followers;
  final int following;

  UserProfile({
    required this.id,
    required this.username,
    required this.name,
    required this.birthday,
    required this.followers,
    required this.following,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      birthday: json['birthday'],
      followers: json['followers'],
      following: json['following'],
    );
  }
}
