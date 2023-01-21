import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/application/log_in/login_bloc.dart';
import 'package:test_1/application/log_in/login_screen.dart';
import 'package:test_1/application/log_in/login_state.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (context) => LoginBloc(LoginInitialState()),
          child: const LoginScreen()),
    );
  }
}
