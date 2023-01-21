import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isVisible;

  const LoginState({this.isVisible = false});

  @override
  List<Object?> get props => [isVisible];
}

class LoginInitialState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {}

class LoginCompleted extends LoginState {}

class LoginFailed extends LoginState {
 final String errorMessage;

  const LoginFailed({required this.errorMessage});
}
