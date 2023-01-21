import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/application/history/history_state.dart';
import 'package:test_1/application/history/histroy_bloc.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    double width = mediaQuery.width;
    double height = mediaQuery.height;

    return BlocBuilder<HistoryBloc, HistoryState>(
        builder: (BuildContext context, HistoryState state) {
      if (state is HistoryFailed) {
        return Center(
          child: Text(state.errorMessage),
        );
      }
      if (state is HistoryCompleted) {
        if (state.history.isEmpty) {
          return const Center(
            child: Text('ليست هناك نتائج لعرضها'),
          );
        }

        return Padding(
          padding: EdgeInsets.only(
              top: height / 29, right: width / 15, left: width / 15),
          child: ListView.builder(
              itemCount: state.history.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateTime.parse(state.history[index].attendanceTime!)
                                .toLocal()
                                .toString(),
                            //  state.history[index].attendanceTime!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: width / 6,
                          ),
                          state.history[index].enter == true
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                  ),
                                )
                              : const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                  ],
                );
              }),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
