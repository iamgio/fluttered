import 'package:flutter/material.dart';

class LoadingSwitcher extends StatelessWidget {
  final bool condition;
  final Duration duration;
  final Widget? ifTrue;
  final Widget? ifFalse;

  const LoadingSwitcher({Key? key, required this.condition, this.duration = const Duration(milliseconds: 500), this.ifTrue, this.ifFalse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchOutCurve: Curves.easeOut,
      child: condition ? ifTrue : ifFalse,
      transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
      layoutBuilder: (current, previous) => Stack(children: [...previous, current!]),
    );
  }
}
