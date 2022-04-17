import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/diet/constants.dart';
import 'package:fluttered/diet/lang.dart';
import 'package:fluttered/diet/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

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

class DietHome extends StatelessWidget {
  const DietHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserViewModel user = context.watch<UserViewModel>();
    return Scaffold(
      backgroundColor: Const.tertiary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          lang['hello_name']! + user.name,
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Const.defaultPadding),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
