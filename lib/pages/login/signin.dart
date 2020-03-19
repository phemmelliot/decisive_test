import 'package:decisive_app/base/base_widget.dart';
import 'package:decisive_app/components/custom_textfield/custom_textfield.dart';
import 'package:decisive_app/core/datastore/profile_repository.dart';
import 'package:decisive_app/core/models/authentication_credentials.dart';
import 'package:decisive_app/core/viewmodels/authentication_viewmodel.dart';
import 'package:decisive_app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BaseWidget<AuthenticationViewModel>(
          model: AuthenticationViewModel(context),
          builder: (context, model, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Decisive',
                      style: TextStyle(
                        color: Helper.primaryColor,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Login to your account',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      key: Key('Email-field'),
                      labelTextString: 'Email',
                      controller: _emailController,
                      validator: (String value) {
                        if (Helper.checkIfFieldIsEmpty(value) != null) {
                          return Helper.checkIfFieldIsEmpty(value);
                        } else if (Helper.validateEmailAddress(value) != null) {
                          return Helper.validateEmailAddress(value);
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      key: Key('Password-Field'),
                      labelTextString: 'Password',
                      isPasswordField: true,
                      controller: _passwordController,
                      validator: (String value) {
                        if (Helper.checkIfFieldIsEmpty(value) != null) {
                          return Helper.checkIfFieldIsEmpty(value);
                        } else if (Helper.validatePassword(value) != null) {
                          return Helper.validatePassword(value);
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'I forgot my password',
                      style: TextStyle(color: Helper.primaryColor, fontSize: 16),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            ProfileRepository profileRepository =
                                Provider.of(context, listen: false);
                            AuthenticationCredentials credentials = AuthenticationCredentials(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );

                            model.performAuthentication(
                              profileRepository,
                              credentials,
                              isSignUp: false,
                            );
                          }
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        color: Helper.primaryColor,
                        child: Text(
                          'Get In',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      child: Text(
                        'Don\'t have an account? Sign Up',
                        style: TextStyle(color: Helper.primaryColor, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
