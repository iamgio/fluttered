import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttered/common/app_navigation.dart';
import 'package:fluttered/common/widgets/loading_switcher.dart';
import 'package:fluttered/diet/constants.dart';
import 'package:fluttered/diet/lang.dart';
import 'package:fluttered/diet/view/diet_page.dart';
import 'package:fluttered/diet/view/recipes_page.dart';
import 'package:fluttered/diet/viewmodel/user_viewmodel.dart';
import 'package:fluttered/diet/widgets/diet_circular_indicator.dart';
import 'package:provider/provider.dart';

class DietHome extends StatefulWidget {
  const DietHome({Key? key}) : super(key: key);

  @override
  State<DietHome> createState() => _DietHomeState();
}

class _DietHomeState extends State<DietHome> {
  int _selectedIndex = 0;
  PageController? _pageController;

  List<NavigationItem>? _navigationItems;

  _onNavigationTap(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController!.animateToPage(
        index,
        duration: const Duration(milliseconds: Const.pageSwitchDuration),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _navigationItems = [
      NavigationItem(
        name: 'Diet',
        androidIcon: SvgPicture.asset('assets/diet/icons/apple.svg', color: Const.primary),
        cupertinoIcon: SvgPicture.asset('assets/diet/icons/apple.svg', color: Const.primary),
        cupertinoSelectedIcon: SvgPicture.asset('assets/diet/icons/apple-fill.svg', color: Const.primary),
        onTap: _onNavigationTap,
      ),
      NavigationItem(
        name: 'Recipes',
        androidIcon: SvgPicture.asset('assets/diet/icons/silverware.svg', color: Const.primary),
        cupertinoIcon: SvgPicture.asset('assets/diet/icons/silverware.svg', color: Const.primary),
        cupertinoSelectedIcon: SvgPicture.asset('assets/diet/icons/silverware-fill.svg', color: Const.primary),
        onTap: _onNavigationTap,
      ),
    ];
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  _buildNavigation() {
    return AppBottomTabBar(items: _navigationItems!);
  }

  _buildAppBar(UserViewModel user) {
    final title = _selectedIndex == 0 ? lang['hello_name']! + user.name : _navigationItems![_selectedIndex].name;
    return AppBar(
      backgroundColor: Colors.transparent,
      title: user.hasLoaded
          ? Text(
              title,
              style: Theme.of(context).textTheme.headline1,
              key: ValueKey(_selectedIndex),
            )
          : null,
      centerTitle: false,
      elevation: 0,
    );
  }

  _buildContent(UserViewModel user) => PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: [
          DietPage(weeklyDiet: user.weeklyDiet),
          const RecipesPage(),
        ],
      );

  @override
  Widget build(BuildContext context) {
    UserViewModel user = context.watch<UserViewModel>();
    return Scaffold(
      backgroundColor: Const.tertiary,
      appBar: _buildAppBar(user),
      body: LoadingSwitcher(
        duration: const Duration(milliseconds: Const.pageSwitchDuration),
        condition: user.hasLoaded,
        ifTrue: _buildContent(user),
        ifFalse: const DietCircularIndicator(),
      ),
      bottomNavigationBar: Opacity(
        opacity: user.hasLoaded ? 1 : 0,
        child: _buildNavigation(),
      ),
    );
  }
}
