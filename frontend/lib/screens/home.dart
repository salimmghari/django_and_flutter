import 'dart:convert';
import 'package:flutter/material.dart' hide Title;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/account/account_bloc.dart';
import '../bloc/account/account_events.dart';
import '../components/layout.dart';
import '../components/title.dart';
import '../components/note.dart';
import '../components/button.dart';
import '../style.dart';
import '../config.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  Dio dio = Dio();
  List<dynamic> notes = [];
  Map<String, String> newNote = {
    'title': '',
    'body': ''
  };

  void initState() {
    SharedPreferences.getInstance()
      .then(
        (SharedPreferences sharedPreferences) async {
          if (!sharedPreferences.containsKey('token')) {
            Navigator.of(context).popAndPushNamed('/auth');
          } else {
            BlocProvider.of<AccountBloc>(context).add(LoginEvent(sharedPreferences.getString('token').toString()));
            Future.delayed(
              Duration.zero, 
              () async => read()
            );
          }
        }
      );
    super.initState();
  }

  void read() {
    dio.get(
      '${Config.url}/api/notes/',
      options: Options(
        headers: {
          'Authorization': 'Token ${BlocProvider.of<AccountBloc>(context).state.token}'
        }
      )
    ).then(
      (Response<dynamic> response) {
        if (response.statusCode == 200) {
          SharedPreferences.getInstance()
            .then(
              (SharedPreferences sharedPreferences) {
                setState(
                  () {
                    dynamic data = (sharedPreferences.getBool('test') == true) ? jsonDecode(response.data) : response.data;
                    notes = data;
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
        print('Read error: ${error}');
      }
    );
  }

  void create() {
    dio.post(
      '${Config.url}/api/notes/',
      data: {
        'title': newNote['title'],
        'body': newNote['body']
      },
      options: Options(
        headers: {
          'Authorization': 'Token ${BlocProvider.of<AccountBloc>(context).state.token}'
        }
      )
    ).then(
      (Response<dynamic> response) {
        if (response.statusCode! <= 201) {
          setState(
            () {
              newNote['title'] = '';
              newNote['body'] = '';
            }
          );
          read();
        } else {
          throw 'Data: ${response.data}. Code: ${response.statusCode}. Message: ${response.statusMessage}';
        }
      }
    ).catchError(
      (dynamic error) {
        print('Create error: ${error}');
      }
    );
  }

  void update(int id, Map<String, String> note) {
    dio.put(
      '${Config.url}/api/notes/${id}/',
      data: {
        'title': note['title'],
        'body': note['body']
      },
      options: Options(
        headers: {
          'Authorization': 'Token ${BlocProvider.of<AccountBloc>(context).state.token}'
        }
      )
    ).then(
      (Response<dynamic> response) {
        if (response.statusCode == 200) {
          read();
        } else {
          throw 'Data: ${response.data}. Code: ${response.statusCode}. Message: ${response.statusMessage}';
        }
      }
    ).catchError(
      (dynamic error) {
        print('Update error: ${error}');
      }
    );
  }

  void delete(int id) {
    dio.delete(
      '${Config.url}/api/notes/${id}/',
      options: Options(
        headers: {
          'Authorization': 'Token ${BlocProvider.of<AccountBloc>(context).state.token}'
        }
      )
    ).then(
      (Response<dynamic> response) {
        if (response.statusCode! <= 204) {
          read();
        } else {
          throw 'Data: ${response.data}. Code: ${response.statusCode}. Message: ${response.statusMessage}';
        }
      }
    ).catchError(
      (dynamic error) {
        print('Delete error: ${error}');
      }
    );
  }

  void logout() {
    dio.post(
      '${Config.url}/api/users/logout/',
      options: Options(
        headers: {
          'Authorization': 'Token ${BlocProvider.of<AccountBloc>(context).state.token}'
        }
      )
    ).then(
      (Response<dynamic> response) {
        if (response.statusCode == 200) {
          SharedPreferences.getInstance()
            .then(
              (SharedPreferences sharedPreferences) {
                sharedPreferences.remove('token');
                BlocProvider.of<AccountBloc>(context).add(LogoutEvent());
                Navigator.of(context).popAndPushNamed('/auth'); 
              }
            );
        } else {
          throw 'Data: ${response.data}. Code: ${response.statusCode}. Message: ${response.statusMessage}';
        }
      }
    ).catchError(
      (dynamic error) {
        print('Logout error: ${error}');
      }
    );
  }

  Widget build(BuildContext context) {
    return Layout(
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Title('Notes'),
          Container(
            margin: Style.tertiaryBottomMargin,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: notes.map(
                    (dynamic note) => Note(
                      title: note['title'],
                      body: note['body'],
                      onTitleChanged: (String value) => note['title'] = value,
                      onBodyChanged: (String value) => note['body'] = value,
                      onUpdate: () => update(
                        note['id'],
                        {
                          'title': note['title'],
                          'body': note['body']
                        }
                      ),
                      onDelete: () => delete(note['id']),
                      titleFieldKey: "Title Field ${note['id']}",
                      bodyFieldKey: "Body Field ${note['id']}",
                      updateButtonKey: "Update Button ${note['id']}",
                      deleteButtonKey: "Delete Button ${note['id']}"
                    )
                  ).toList()
                ),
                Note(
                  title: newNote['title']!,
                  body: newNote['body']!,
                  onTitleChanged: (String value) => newNote['title'] = value,
                  onBodyChanged: (String value) => newNote['body'] = value,
                  onCreate: create,
                  last: true,
                  titleFieldKey: 'Title Field',
                  bodyFieldKey: 'Body Field',
                  createButtonKey: 'Create Button'
                )
              ]
            )
          ),
          Button(
            logout,
            title: 'Logout',
            icon: Icons.logout,
            color: Style.dangerColor
          )
        ]
      )
    );
  }
}
