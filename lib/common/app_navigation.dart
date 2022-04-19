import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationItem {
  final String name;
  final Widget androidIcon;
  final Widget cupertinoIcon;
  final Widget? cupertinoSelectedIcon;
  final Function(int) onTap;

  const NavigationItem({
    required this.name,
    required this.androidIcon,
    required this.cupertinoIcon,
    this.cupertinoSelectedIcon,
    required this.onTap,
  });
}

// For Android
class AppDrawer extends StatelessWidget {
  final List<NavigationItem> items;
  final int selectedIndex;
  final Function(int) onSelect;
  final Color? selectedColor;
  const AppDrawer({Key? key, required this.items, required this.selectedIndex, required this.onSelect, this.selectedColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ...items.map(
            (item) => ListTile(
              title: Text(item.name, style: Theme.of(context).textTheme.headline2),
              leading: item.androidIcon,
              selected: item == items[selectedIndex],
              selectedTileColor: selectedColor,
              onTap: () {
                Navigator.pop(context);
                onSelect(items.indexOf(item));
                item.onTap(items.indexOf(item));
              },
            ),
          ),
        ],
      ),
    );
  }
}

// For iOS
class AppBottomTabBar extends StatefulWidget {
  final List<NavigationItem> items;
  final int selectedIndex;
  final Function(int) onSelect;
  final double iconSize;
  final PageController? pageController;
  const AppBottomTabBar({Key? key, required this.items, required this.selectedIndex, required this.onSelect, this.iconSize = 30.0, this.pageController}) : super(key: key);

  @override
  _AppBottomTabBarState createState() => _AppBottomTabBarState();
}

class _AppBottomTabBarState extends State<AppBottomTabBar> {

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      iconSize: widget.iconSize,
      onTap: (index) {
        setState(() {
          widget.items[index].onTap(index);
          widget.onSelect(index);
        });
      },
      currentIndex: widget.selectedIndex,
      items: widget.items
          .map(
            (item) => BottomNavigationBarItem(
              icon: item.cupertinoIcon,
              activeIcon: item.cupertinoSelectedIcon ?? item.cupertinoIcon,
              label: item.name,
            ),
          )
          .toList(),
    );
  }
}
