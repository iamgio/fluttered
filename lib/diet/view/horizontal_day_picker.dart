import 'package:flutter/material.dart';
import 'package:fluttered/diet/constants.dart';
import 'package:fluttered/diet/lang.dart';

class HorizontalDayPicker extends StatefulWidget {
  final int selectedDay;
  final Function(int)? onSelect;

  const HorizontalDayPicker({Key? key, required this.selectedDay, this.onSelect}) : super(key: key);

  @override
  State<HorizontalDayPicker> createState() => _HorizontalDayPickerState();
}

class _HorizontalDayPickerState extends State<HorizontalDayPicker> {
  final List<GlobalKey> _textsKeys = List.generate(7, (_) => GlobalKey());
  double _indicatorPosition = 0;
  int _lastSelectedDay = -1;

  _buildDay(int day) => GestureDetector(
        onTap: () {
          widget.onSelect?.call(day);
          _moveIndicatorTo(day);
        },
        child: AnimatedOpacity(
          opacity: widget.selectedDay == day ? 1 : .5,
          duration: const Duration(milliseconds: Const.daySwitchDuration),
          curve: Curves.easeInOut,
          child: Text(
            lang['day.$day']!,
            style: Theme.of(context).textTheme.headline4,
            key: _textsKeys[day],
          ),
        ),
      );

  _buildDayIndicator() => AnimatedPadding(
        duration: const Duration(milliseconds: Const.daySwitchDuration),
        padding: EdgeInsets.only(left: _indicatorPosition, top: 3),
        child: Container(
          width: Const.dayPickerIndicatorSize,
          height: Const.dayPickerIndicatorSize,
          decoration: const BoxDecoration(
            color: Const.primary,
            shape: BoxShape.circle,
          ),
        ),
      );

  _moveIndicatorTo(int day) {
    _lastSelectedDay = day;
    RenderBox box = _textsKeys[day].currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(const Offset(-Const.defaultPadding, 0));
    setState(() {
      _indicatorPosition = position.dx + box.size.width / 2 - Const.dayPickerIndicatorSize / 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_lastSelectedDay != widget.selectedDay) {
      // If a page is switched via PageView gestures
      if(_lastSelectedDay == -1) { // Unset: wait for animations to finish
        Future.delayed(
          const Duration(milliseconds: Const.pageSwitchDuration),
              () => _moveIndicatorTo(widget.selectedDay),
        );
      } else {
        _moveIndicatorTo(widget.selectedDay);
      }
    }
    return Padding(
      padding: const EdgeInsets.all(Const.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) => _buildDay(index)),
          ),
          _buildDayIndicator(),
        ],
      ),
    );
  }
}
