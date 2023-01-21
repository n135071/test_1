import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/application/history/history_event.dart';
import 'package:test_1/application/history/history_state.dart';
import 'package:test_1/data/history_repository.dart';
import 'package:test_1/models/response_model.dart';

import '../../models/history.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc(super.initialState) {
    on<LoadHistory>(getHistory);
  }

  void getHistory(HistoryEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    HistoryRepository historyRepository = HistoryRepository();
    ResponseModel<List<History>> response =
        await historyRepository.getHistory();
    if (response.hasError) {
      emit(HistoryFailed(errorMessage: response.message));
    } else {
      emit(HistoryCompleted(history: response.data!));
    }
  }
}
