import 'package:mobile/data/models/enigma_user.dart';

class IaRequest {
  int requestId;
  EnigmaUser follower;

  IaRequest({required this.requestId, required this.follower});

  factory IaRequest.fromJson(Map<String, dynamic> json) {
    return IaRequest(
      requestId: json['requestId'],
      follower: EnigmaUser.fromJson(json['follower']),
    );
  }
}
