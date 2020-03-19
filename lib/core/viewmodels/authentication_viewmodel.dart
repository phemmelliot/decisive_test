import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisive_app/base/base_model.dart';
import 'package:decisive_app/core/datastore/profile_repository.dart';
import 'package:decisive_app/core/models/authentication_credentials.dart';
import 'package:decisive_app/core/models/userprofile.dart';
import 'package:decisive_app/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AuthenticationViewModel extends BaseModel {
  final BuildContext context;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _fireStore = Firestore.instance;

  AuthenticationViewModel(this.context);

  void performAuthentication(
      ProfileRepository profileRepository, AuthenticationCredentials credentials,
      {bool isSignUp = true}) async {
    try {
      Helper.showPlatformProgressIndicator(context);
      FirebaseUser user;
      if (isSignUp) {
        user = await _signUpToUserDb(credentials);
        if(user != null){
          UserProfile userProfile = UserProfile(
            userEmail: user.email,
            userId: user.uid,
            userName: credentials.name,
            userPhoneNumber: credentials.phoneNumber,
          );
          await _saveUserToDB(user.uid, userProfile);
          profileRepository.setUserProfile = userProfile;
          Helper.dismissDialog(context);
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        user = await _loginToUserDb(credentials);
        Map<String, dynamic> userJson = await _getUserFromDB(user.uid);
        // save the user object after logging the user in
        profileRepository.setUserProfile = UserProfile.fromJson(userJson);
        Helper.dismissDialog(context);
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on PlatformException catch (error) {
      Helper.dismissDialog(context);
      Helper.displayError(error.message, context);
    }
  }

  Future<FirebaseUser> _signUpToUserDb(AuthenticationCredentials credentials) async {
    return (await _auth.createUserWithEmailAndPassword(
      email: credentials.email,
      password: credentials.password,
    ))
        .user;
  }

  Future<void> _saveUserToDB(String userId, UserProfile userProfile) async {
    await _fireStore.collection('users').document(userId).setData(userProfile.toMap());
  }

  Future<Map<String, dynamic>> _getUserFromDB(String userId) async {
    Map<String, dynamic> userJson =
        (await _fireStore.collection('users').document(userId).get()).data;

    return userJson;
  }

  Future<FirebaseUser> _loginToUserDb(AuthenticationCredentials credentials) async {
    return (await _auth.signInWithEmailAndPassword(
      email: credentials.email,
      password: credentials.password,
    ))
        .user;
  }
}
