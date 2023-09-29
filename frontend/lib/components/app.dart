import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/account/account_bloc.dart';
import '../screens/home.dart';
import '../screens/auth.dart';
import '../style.dart';
import '../config.dart';



class App extends StatelessWidget {
  final String initialRoute;

  const App({
    this.initialRoute = '/',
    Key? key
  }) : super(key: key);

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountBloc>(
          create: (BuildContext context) => AccountBloc()
        )
      ],
      child: MaterialApp(
        title: Config.name,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          primaryColor: Style.primaryColor, 
          colorScheme: ColorScheme
            .fromSwatch()
            .copyWith(
              secondary: Style.secondaryColor
            )
        ),
        initialRoute: initialRoute,
        routes: {
          '/': (BuildContext context) => const HomeScreen(),
          '/auth': (BuildContext context) => const AuthScreen()
        }
      )
    );
  }
}
