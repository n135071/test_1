import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/application/log_in/login_bloc.dart';
import 'package:test_1/application/log_in/widgets/text_form.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = context.read<LoginBloc>();
    var mediaQuery = MediaQuery.of(context).size;
    double width = mediaQuery.width;
    double height = mediaQuery.height;
    return SingleChildScrollView(
      child: Form(
        key: loginBloc.formKey,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.2,
            ),
            InputTextForm(
              formValidator: loginBloc.usernameValidator,
              prefixIcon: Icons.person,

            ),
            SizedBox(
              height: height * 0.03,
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
            SizedBox(
              height: height * 0.05,
            ),
            SizedBox(
              width: width / 2,
              child: ElevatedButton(
                onPressed: () {
                  loginBloc.add(LoginPressed());
                },
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
