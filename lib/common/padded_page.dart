import 'package:flutter/material.dart';
import 'package:fluttered/diet/constants.dart';

class PaddedPage extends StatelessWidget {
  final Widget child;

  const PaddedPage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Const.defaultPadding),
        child: child,
      ),
    );
  }
}
