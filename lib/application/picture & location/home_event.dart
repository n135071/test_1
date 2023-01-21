
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPicture extends HomeEvent {
  final String type ;

  GetPicture({required this.type});
}

class GetLocation extends HomeEvent {}
class Changeindex extends HomeEvent{
  final int index;

   Changeindex({required this.index});
}
