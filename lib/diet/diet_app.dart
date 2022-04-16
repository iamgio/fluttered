import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DietApp extends StatelessWidget {
  const DietApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DietHome(),
    );
  }
}

class DietHome extends StatelessWidget {
  const DietHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Diet'),
      ),
    );
  }
}
