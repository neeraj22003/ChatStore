import 'package:flutter/material.dart';

class CustomAdaptiveLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldstatekey;
  final PreferredSizeWidget? appbar;
  final Widget pages;
  final void Function(int?)? onNavigationTap;
  final int? selectedIndex;
  final Widget? endDrawer;
  final List<NavigationList>? navigtionlist;
  final Widget? firstchildforbiggscreen;

  final Widget? floatingactionButton;
  const CustomAdaptiveLayout({
    super.key,
    this.firstchildforbiggscreen,
    this.scaffoldstatekey,
    this.appbar,
    required this.pages,
    this.onNavigationTap,
    this.selectedIndex,
    this.endDrawer,
    this.navigtionlist,
    this.floatingactionButton,
  });

  Widget navigationRail(ColorScheme color, double width) {
    return navigtionlist !=null&&firstchildforbiggscreen==null
        ? NavigationRail(
            scrollable: true,
            selectedIconTheme: IconThemeData(size: 28, color: color.primary),
            indicatorColor: Colors.white,
            backgroundColor: Colors.white,
            minWidth: width > 850 ? 160 : 120,
            destinations: navigtionlist!
                .map(
                  (data) => NavigationRailDestination(
                    icon: Icon(data.icon),
                    label: Text(data.title),
                  ),
                )
                .toList(),
            selectedIndex: selectedIndex,
            onDestinationSelected: onNavigationTap,
          )
        : const SizedBox.shrink();
  }

  Widget bottomNavigation() {
    return navigtionlist != null
        ? NavigationBar(
            backgroundColor: Colors.white,
            destinations: navigtionlist!
                .map(
                  (data) => NavigationDestination(
                    icon: Icon(data.icon),
                    label: data.title,
                  ),
                )
                .toList(),
            selectedIndex: selectedIndex??0,
            onDestinationSelected: onNavigationTap,
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final themecolor = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 480) {
          return Row(
            children: [
             firstchildforbiggscreen!=null? Expanded(child: firstchildforbiggscreen!):const SizedBox.shrink(),
              navigationRail(themecolor, constraints.maxWidth),
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: themecolor.outlineVariant,
              ),
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  key: scaffoldstatekey,
                  appBar: appbar,
                  body: pages,
                  floatingActionButton: floatingactionButton,
                  endDrawer: endDrawer,
                ),
              ),
            ],
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            key: scaffoldstatekey,
            appBar: appbar,
            body: pages,
            floatingActionButton: floatingactionButton,
            bottomNavigationBar: bottomNavigation(),
            endDrawer: Drawer(
              width: constraints.maxWidth,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: endDrawer,
            ),
          );
        }
      },
    );
  }
}

class NavigationList {
  final IconData icon;
  final String title;
  NavigationList({required this.icon, required this.title});
}
