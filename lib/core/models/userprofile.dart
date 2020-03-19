import 'package:flutter/cupertino.dart';

class UserProfile {
  String userName,
      userPhoneNumber,
      userEmail,
      userId;

  UserProfile({
    @required this.userName,
    @required this.userPhoneNumber,
    @required this.userEmail,
    @required this.userId,
  });

  Map toMap(){
    Map<String, dynamic> map = Map();
    map['user_name'] = userName;
    map['user_phone_number'] = userPhoneNumber;
    map['user_email'] = userEmail;
    map['user_id'] = userId;

    return map;
  }

  UserProfile.fromJson(Map<String, dynamic> map){
    userName = map['user_name'];
    userPhoneNumber = map['user_phone_number'];
    userEmail = map['user_email'];
    userId = map['user_id'];
  }
}
