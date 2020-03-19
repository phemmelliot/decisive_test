import 'package:decisive_app/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkPreferenceAndGoToLogin(context);
  }

  Future<void> checkPreferenceAndGoToLogin(BuildContext context) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      await Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    } else {
      await Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.pushReplacementNamed(context, '/signup');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: Text(
            'Decisive',
            style: TextStyle(
              color: Helper.primaryColor,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
