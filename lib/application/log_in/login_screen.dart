import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_1/application/log_in/login_bloc.dart';
import 'package:test_1/application/log_in/login_event.dart';
import 'package:test_1/application/log_in/login_state.dart';
import 'package:test_1/application/log_in/widgets/text_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // LoginBloc loginBloc=BlocProvider.of<LoginBloc>(context);
    LoginBloc loginBloc = context.read<LoginBloc>();
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, LoginState state) {
        if (state is LoginLoading) {
          showDialog(
              context: context,
              builder: (context) => const Center(child:  CircularProgressIndicator()));
        } else if (state is LoginFailed) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: state.errorMessage);
        } else if (state is LoginCompleted) {
          Navigator.pop(context);


// navicator.push
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'LogIn',
            style: TextStyle(),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: loginBloc.formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              InputTextForm(
                formValidator: loginBloc.usernameValidator,
                prefixIcon: Icons.person,
              ),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, LoginState state) => InputTextForm(
                  formValidator: loginBloc.passwordValidator,
                  prefixIcon: Icons.password,
                  suffixIcon:
                      state.isVisible ? Icons.visibility : Icons.visibility_off,
                  showText: state.isVisible,
                  suffixPressed: () {
                    loginBloc.add(TogglePassword());
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    loginBloc.add(LoginPressed());
                  },
                  child: const Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
