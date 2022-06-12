import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/diet/constants.dart';
import 'package:simple_animations/simple_animations.dart';

class RecipesFilterButton extends StatefulWidget {
  final Widget child;
  final Function(bool)? onChanged;
  const RecipesFilterButton({Key? key, required this.child, this.onChanged}) : super(key: key);

  @override
  State<RecipesFilterButton> createState() => _RecipesFilterButtonState();
}

class _RecipesFilterButtonState extends State<RecipesFilterButton> with AnimationMixin {
  bool _isActive = false;
  late Animation<Color?> _color; // Button background color animation

  @override
  void initState() {
    _color = ColorTween(begin: null, end: Const.primary).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
    controller.duration = const Duration(milliseconds: Const.recipesFilterPressAnimationDuration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      // Same height for every button
      child: MaterialButton(
        onPressed: () {
          setState(() {
            _isActive ^= true;
            widget.onChanged?.call(_isActive);
            if (_isActive) {
              controller.play();
            } else {
              controller.playReverse();
            }
          });
        },
        elevation: 0,
        splashColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Const.primary, width: Const.recipesSearchDefaultBorderWidth),
          borderRadius: BorderRadius.circular(Const.recipesFilterRadius),
        ),
        color: _color.value,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: Const.recipesFilterPressAnimationDuration),
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: _isActive ? Const.tertiary : Const.primary,
              ),
          child: widget.child,
        ),
      ),
    );
  }
}
