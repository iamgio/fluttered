import 'package:flutter/material.dart';

class LoadingSwitcher extends StatelessWidget {
  final bool condition;
  final Duration duration;
  final Widget? ifTrue;
  final Widget? ifFalse;

  const LoadingSwitcher({Key? key, required this.condition, this.duration = const Duration(milliseconds: 500), this.ifTrue, this.ifFalse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: duration,
          switchInCurve: Curves.easeInOut,
          child: condition ? ifTrue : null,
          transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
        ),
        AnimatedSwitcher(
          duration: duration,
          switchOutCurve: Curves.easeInSine,
          child: condition ? null : ifFalse,
          transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
        ),
      ],
    );
  }
}
