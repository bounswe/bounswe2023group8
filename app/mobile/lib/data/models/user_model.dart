class UserModel {
  final int id;
  final String name;
  final String username;
  final List<int> iaIds;
  final int followerCount;
  final int followingCount;
  final int allTimeLikes;
  final int allTimeDislikes;
  final String userProfileImage;

  const UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.iaIds,
    required this.followerCount,
    required this.followingCount,
    required this.allTimeLikes,
    required this.allTimeDislikes,
    required this.userProfileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['nickname'],
      iaIds: json['ia_ids'].cast<int>(),
      followerCount: json['follower_count'],
      followingCount: json['following_count'],
      allTimeLikes: json['all_time_likes'],
      allTimeDislikes: json['all_time_dislikes'],
      userProfileImage: json['user_profile_image'],
    );
  }
}
