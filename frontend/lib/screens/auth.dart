import 'dart:convert';
import 'package:flutter/material.dart' hide Form, Title;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/account/account_bloc.dart';
import '../bloc/account/account_events.dart';
import '../components/layout.dart';
import '../components/form.dart';
import '../components/field.dart';
import '../components/button.dart';
import '../components/title.dart';
import '../components/link.dart';
import '../config.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  State<AuthScreen> createState() => _AuthScreenState();
}


class _AuthScreenState extends State<AuthScreen> {
  Dio dio = Dio();
  String type = 'login';
  String username = '';
  String password = '';
  String newUsername = '';
  String newPassword = '';
  String confirmNewPassword = '';

  void login() {
    if (
      username.isNotEmpty
      && password.isNotEmpty
    ) {
      dio.post(
        '${Config.url}/api/users/login/',
        data: {
          'username': username,
          'password': password
        }
      ).then(
        (Response<dynamic> response) {
          if (response.statusCode == 200) {
            SharedPreferences.getInstance()
              .then(
                (SharedPreferences sharedPreferences) {
                  dynamic data = (sharedPreferences.getBool('test') == true) ? jsonDecode(response.data) : response.data;
                  String token = data['token'];
                  sharedPreferences.setString('token', token);
                  BlocProvider.of<AccountBloc>(context).add(LoginEvent(token));
                  Future.delayed(
                    Duration.zero, 
                    () async {
                      Navigator.of(context).popAndPushNamed('/');
                    }
                  );                  
                }
              );              
          } else {
            throw 'Data: ${response.data}. Code: ${response.statusCode}. Message: ${response.statusMessage}';
          }
        }
      ).catchError(
        (dynamic error) {
          print('Login error: ${error}');
        }
      );
    }
  }

  void signup() {
    if (
      newUsername.isNotEmpty
      && newPassword.isNotEmpty
      && confirmNewPassword == newPassword
    ) {
      dio.post(
        '${Config.url}/api/users/signup/',
        data: {
          'username': newUsername,
          'password': newPassword
        }
      ).then(
        (Response<dynamic> response) {
          if (response.statusCode! <= 201) {
            SharedPreferences.getInstance()
              .then(
                (SharedPreferences sharedPreferences) {
                  dynamic data = (sharedPreferences.getBool('test') == true) ? jsonDecode(response.data) : response.data;
                  String token = data['token'];
                  sharedPreferences.setString('token', token);
                  BlocProvider.of<AccountBloc>(context).add(LoginEvent(token));
                  Future.delayed(
                    Duration.zero, 
                    () async {
                      Navigator.of(context).popAndPushNamed('/');
                    }
                  );                  
                }
              );              
          } else {
            throw 'Data: ${response.data}. Code: ${response.statusCode}. Message: ${response.statusMessage}';
          }
        }
      ).catchError(
        (dynamic error) {
          print('Signup error: ${error}');
        }
      );
    }
  }

  Widget build(BuildContext context) {
    return Layout(
      Container(
        height: MediaQuery.of(context).size.height,
        child: type == 'login' ? Form(
          [
            const Title('Login'),
            Field(
              (String value) => setState(
                () => username = value
              ),
              label: 'Username:',
              fieldKey: 'Username Field'
            ),
            Field(
              (String value) => setState(
                () => password = value
              ),
              label: 'Password:',
              secure: true,
              fieldKey: 'Password Field'
            ),
            Link(
              () => setState(
                () => type = 'signup'
              ),
              title: 'Signup?',
              linkKey: 'Signup Link',
              margin: true
            ),
            Button(
              login,
              title: 'Login',
              icon: Icons.login,
              buttonKey: 'Login Button'
            )
          ]
        ) : Form (
          [
            const Title('Signup'),
            Field(
              (String value) => setState(
                () => newUsername = value
              ),
              label: 'Username:',
              fieldKey: 'New Username Field'
            ),
            Field(
              (String value) => setState(
                () => newPassword = value
              ),
              label: 'Password:',
              secure: true,
              fieldKey: 'New Password Field'
            ),
            Field(
              (String value) => setState(
                () => confirmNewPassword = value
              ),
              label: 'Confirm Password:',
              secure: true,
              fieldKey: 'Confirm New Password Field'
            ),
            Link(
              () => setState(
                () => type = 'login'
              ),
              title: 'Login?',
              linkKey: 'Login Link',
              margin: true
            ),
            Button(
              signup,
              title: 'Signup',
              icon: Icons.edit,
              buttonKey: 'Signup Button'
            )
          ]
        )
      ) 
    );
  }
}
