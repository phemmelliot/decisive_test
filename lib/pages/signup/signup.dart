import 'package:decisive_app/base/base_widget.dart';
import 'package:decisive_app/components/custom_textfield/custom_textfield.dart';
import 'package:decisive_app/core/datastore/profile_repository.dart';
import 'package:decisive_app/core/models/authentication_credentials.dart';
import 'package:decisive_app/core/viewmodels/authentication_viewmodel.dart';
import 'package:decisive_app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                      ),
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
                        'Create Account',
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        key: Key('Name-Field'),
                        labelTextString: 'Name',
                        controller: _nameController,
                        validator: (String value) {
                          if (Helper.checkIfFieldIsEmpty(value) != null) {
                            return Helper.checkIfFieldIsEmpty(value);
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
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
                        key: Key('Phone-Field'),
                        labelTextString: 'Phone',
                        controller: _phoneController,
                        validator: (String value) {
                          if (Helper.checkIfFieldIsEmpty(value) != null) {
                            return Helper.checkIfFieldIsEmpty(value);
                          } else if (Helper.validatePhoneNumber(value) != null) {
                            return Helper.validatePhoneNumber(value);
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
                      CustomTextField(
                        key: Key('Confirm-Field'),
                        labelTextString: 'Confirm Password',
                        isPasswordField: true,
                        controller: _confirmPasswordController,
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
                                  phoneNumber: _phoneController.text,
                                  name: _nameController.text);

                              if (_confirmPasswordController.text != _passwordController.text) {
                                Helper.displayError('Password does not match', context);
                              } else {
                                model.performAuthentication(profileRepository, credentials,
                                    isSignUp: true);
                              }
                            }
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          color: Helper.primaryColor,
                          child: Text(
                            'Create Account',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        child: Text(
                          'Already have an account? Sign In',
                          style: TextStyle(color: Helper.primaryColor, fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
