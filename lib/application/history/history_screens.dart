import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/application/history/history_body.dart';
import 'package:test_1/application/history/history_state.dart';
import 'package:test_1/application/history/histroy_bloc.dart';

import '../picture & location/bootomnavecator.dart';
import 'history_event.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Bottom(
        currentIndex: 1,
      ),
      appBar: AppBar(
        title: const Text('History Page'),
      ),
      body: BlocProvider<HistoryBloc>(
        create: (context) =>
            HistoryBloc(HistoryInitialState())..add(LoadHistory()),
        child: const HistoryBody(),
      ),
    );
  }
}
