import 'package:flutter/material.dart';
import 'package:fluttered/common/widgets/centered.dart';
import 'package:fluttered/diet/constants.dart';

class DietCircularIndicator extends StatelessWidget {
  const DietCircularIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Centered(
      child: CircularProgressIndicator(
        color: Const.primary,
        strokeWidth: 10,
      ),
    );
  }
}
