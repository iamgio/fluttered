import 'package:flutter/material.dart';
import 'package:fluttered/common/widgets/loading_switcher.dart';
import 'package:fluttered/diet/constants.dart';
import 'package:fluttered/diet/lang.dart';
import 'package:fluttered/diet/viewmodel/user_viewmodel.dart';
import 'package:fluttered/diet/widgets/diet_circular_indicator.dart';
import 'package:provider/provider.dart';

class DietHome extends StatelessWidget {
  const DietHome({Key? key}) : super(key: key);

  _buildContent(UserViewModel user) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Const.defaultPadding),
          child: Column(
            children: [],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    UserViewModel user = context.watch<UserViewModel>();
    return Scaffold(
      backgroundColor: Const.tertiary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: user.hasLoaded
            ? Text(
                lang['hello_name']! + user.name,
                style: Theme.of(context).textTheme.headline1,
              )
            : null,
        centerTitle: false,
        elevation: 0,
      ),
      body: LoadingSwitcher(
        condition: user.hasLoaded,
        ifTrue: _buildContent(user),
        ifFalse: const DietCircularIndicator(),
      ),
    );
  }
}
