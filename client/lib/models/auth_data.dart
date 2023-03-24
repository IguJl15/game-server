import 'package:flutter/services.dart';

class AuthData {
  String sessionId;
  String nickName;

  AuthData({
    required this.sessionId,
    required this.nickName,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    print(json);
    return AuthData(
      sessionId: json['sessionId'],
      nickName: json['nickName'],
    );
  }
}
