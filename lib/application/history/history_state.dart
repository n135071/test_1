import 'package:equatable/equatable.dart';

import '../../models/history.dart';

class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryInitialState extends HistoryState {
  @override
  List<Object?> get props => [];
}

class HistoryLoading extends HistoryState {}

class HistoryCompleted extends HistoryState {
  final List<History> history;

  const HistoryCompleted({required this.history});
}

class HistoryFailed extends HistoryState {
  final String errorMessage;

  const HistoryFailed({required this.errorMessage});
}
