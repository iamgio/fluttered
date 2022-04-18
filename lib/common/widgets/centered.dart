import 'package:flutter/material.dart';

/// Like [Center], but takes [AppBar] height into account.
class Centered extends StatelessWidget {
  final Widget child;
  const Centered({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          SizedBox(height: AppBar().preferredSize.height),
        ],
      ),
    );
  }
}
