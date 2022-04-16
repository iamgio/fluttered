import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttered/diet/diet_app.dart';

void main() {
  StatelessWidget app = _getFromCommandLine() ?? _getRandomApp();
  runApp(app);
}

const Map<String, StatelessWidget> apps = {
  'diet': DietApp(),
};

const appArgName = 'app';

StatelessWidget _getRandomApp() => apps.entries.elementAt(Random().nextInt(apps.length)).value;

StatelessWidget? _getFromCommandLine() {
  // The next lines get the app to be run from command line via:
  // flutter run --dart-define="app=APPNAME"

  if(const bool.hasEnvironment(appArgName)) {
    const appName = String.fromEnvironment(appArgName);
    return apps[appName];
  }
  return null;
}