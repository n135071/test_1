import 'dart:io';

import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {}

class HomeCompleted extends HomeState {
  final String result;

  const HomeCompleted({required this.result});
}

class HomeFailed extends HomeState {
  final String errorMessage;

  const HomeFailed({required this.errorMessage});
}

class HomeLocationCompleted extends HomeState {
  final String longtude;
  final String lattude;

  const HomeLocationCompleted({required this.lattude, required this.longtude});
}

class HomeGetLocationFailed extends HomeState {
  final String errorMessage;

  const HomeGetLocationFailed({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class ShowImageInScreen extends HomeState {
  final File imageFile;


  const ShowImageInScreen({required this.imageFile});

  @override
  List<Object?> get props => [imageFile];
}

class InformationNotCompleted extends HomeState {}
