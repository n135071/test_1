import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/application/picture%20&%20location/home_bloc.dart';
import 'package:test_1/application/picture%20&%20location/home_body.dart';
import 'package:test_1/application/picture%20&%20location/home_state.dart';
import 'package:test_1/data/token.dart';

import 'bootomnavecator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return HomeBloc(HomeInitialState());
      },
      child: Scaffold(
        bottomNavigationBar: const Bottom(
          currentIndex: 0,
        ),
        appBar: AppBar(
          title: const Text('HomePage'),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('تسجيل خروج'),
              onTap: () async {
                await Token().deleteTokens(access: true, refresh: true);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: const HomeBody(),
      ),
    );
  }
}
