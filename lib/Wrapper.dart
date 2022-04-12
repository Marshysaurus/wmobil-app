import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wmobil/main.dart';
import 'package:wmobil/screens/app/login/LoginScreen.dart';
import 'package:wmobil/streams/User.dart';

GetIt getIt = GetIt.instance;

class Wrapper extends StatelessWidget {
  final user = getIt.get<User>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: user.stream$,
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.data == null) {
            return LoginScreen();
          }

          return HomePage();
        });
  }
}
