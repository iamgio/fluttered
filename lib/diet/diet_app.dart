import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/diet/constants.dart';
import 'package:fluttered/diet/view/home.dart';
import 'package:fluttered/diet/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

import 'data/data.dart';

class DietApp extends StatelessWidget {
  const DietApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel(data_getUser())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColor: Const.primary,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: Const.h1,
              fontWeight: FontWeight.w900,
            ),
            headline2: TextStyle(
              fontSize: Const.h2,
              fontWeight: FontWeight.bold,
            ),
            headline3: TextStyle(
              fontSize: Const.h3,
              fontWeight: FontWeight.bold,
            ),
            headline4: TextStyle(
              fontSize: Const.h4,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(fontSize: Const.b1),
            bodyText2: TextStyle(fontSize: Const.b2),
          ).apply(
            bodyColor: Const.primary,
            displayColor: Const.primary,
          ),
        ),
        home: const DietHome(),
      ),
    );
  }
}
