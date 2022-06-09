import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/diet/constants.dart';

class RecipesFilterButton extends StatefulWidget {
  final Widget child;
  final Function(bool)? onChanged;
  const RecipesFilterButton({Key? key, required this.child, this.onChanged}) : super(key: key);

  @override
  State<RecipesFilterButton> createState() => _RecipesFilterButtonState();
}

class _RecipesFilterButtonState extends State<RecipesFilterButton> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      // Same height for every button
      child: MaterialButton(
        onPressed: () {
          setState(() {
            _isActive ^= true;
            widget.onChanged?.call(_isActive);
          });
        },
        padding: const EdgeInsets.all(Const.recipesFilterPadding),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Const.primary, width: Const.recipesSearchDefaultBorderWidth),
          borderRadius: BorderRadius.circular(Const.recipesFilterRadius),
        ),
        color: _isActive ? Const.primary : null,
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.headline4!.copyWith(
            color: _isActive ? Const.tertiary : Const.primary,
          ),
            child: widget.child
        ),
      ),
    );
  }
}
