import 'package:decisive_app/core/models/userprofile.dart';
import 'package:flutter/cupertino.dart';

class ProfileRepository extends ChangeNotifier {
  ProfileRepository();

  UserProfile _userProfile;

  UserProfile get userProfile => _userProfile;

  set setUserProfile(UserProfile value) {
    _userProfile = value;
    notifyListeners();
  }

  void clearUserProfile(){
    _userProfile = null;
  }

}
