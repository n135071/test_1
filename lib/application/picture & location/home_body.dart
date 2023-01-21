import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    double width = mediaQuery.width;
    double height = mediaQuery.height;

    String type = '';
    File? image;
    HomeBloc homeBloc = context.read<HomeBloc>();

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeGetLocationFailed) {
          Fluttertoast.showToast(msg: state.errorMessage);
        } else if (state is HomeFailed) {
          Fluttertoast.showToast(msg: state.errorMessage);
        } else if (state is HomeCompleted) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('النتيجة'),
                  content: Text(state.result),
                );
              });
          image = null;
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ShowImageInScreen) {
          image = state.imageFile;
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (image == null)
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.asset(
                          'assets/image_not.jpg',
                          width: width / 2,
                        ),
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.file(
                          image!,
                          width: width / 2,
                        ),
                      ),
                    ),
              SizedBox(
                height: height * 0.03,
              ),
              ElevatedButton(
                onPressed: () {
                  type = 'FACE';
                  homeBloc.add(GetPicture(type: type));
                },
                child: SizedBox(
                  width: width * 0.3,
                  child: const Text(
                    'التقاط صورة Face',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  type = 'QR';
                  homeBloc.add(GetPicture(type: type));
                },
                child: SizedBox(
                  width: width * 0.3,
                  child: const Text(
                    'التقاط صورة QR',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
            ],
          ),
        );
      },
    );
  }
}
