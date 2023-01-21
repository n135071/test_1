import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_1/application/log_in/login_state.dart';
import 'package:test_1/data/user_repository.dart';
import 'package:test_1/models/form_validator.dart';
import '../../models/user.dart';
import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(super.initialState) {
    on<TogglePassword>(togglePassword);
    on<LoginPressed>(submit);
  }

  FormValidator usernameValidator = FormValidator(
      hint: 'Username',
      regExp: RegExp(r'^.{3,}$'),
      errorMessage: 'username should be 3 character or more');
  FormValidator passwordValidator = FormValidator(
      hint: 'Password',
      regExp: RegExp(r'^.{3,}$'),
      errorMessage: 'password should be 3 character or more');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void togglePassword(TogglePassword event, Emitter<LoginState> emit) {
    emit(LoginState(isVisible: !state.isVisible));
  }

  Future<void> submit(LoginPressed event, Emitter<LoginState> emit) async {
    if (!formKey.currentState!.validate()) return;
    emit(LoginLoading());
    UserRepository userRepository = UserRepository();
    String response = await userRepository.login(User(
        username: usernameValidator.controller.text,
        password: passwordValidator.controller.text));
    if (response == 'completed') {
      usernameValidator.controller.clear();
      passwordValidator.controller.clear();
      emit(LoginCompleted());
    } else {
      emit(LoginFailed(errorMessage:response ));
    }
  }
}
