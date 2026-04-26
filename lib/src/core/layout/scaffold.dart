import 'package:flutter/material.dart';
import 'package:chat_shop/src/core/layout/widgets/appbar.dart';
import 'package:chat_shop/src/core/layout/widgets/navigation_bar.dart';
import 'package:chat_shop/src/features/chats/ui/screen/history_chat.dart';
import 'package:chat_shop/src/features/orders/ui/screen/orderpage.dart';
import 'package:chat_shop/src/features/search/ui/screen/search_page.dart';
import 'package:chat_shop/src/features/search_users/ui/screen/users_page.dart';
import 'package:chat_shop/src/features/user/ui/screen/acount_dashboard.dart';
import 'package:chat_shop/src/features/cart/ui/screen/cart_page.dart';
import 'package:chat_shop/src/features/search/ui/widgets/floating_cart_button.dart';

import 'package:chat_shop/src/core/layout/providers/navigation_provider.dart';

import 'package:provider/provider.dart';

class WideScaffolds extends StatelessWidget {
  const WideScaffolds({super.key});
  @override
  Widget build(BuildContext context) {
    final themecolor = Theme.of(context).colorScheme;
    final provider = context.watch<NavigationProvider>();
    final List<Widget> pages = [
      Search(),
      UsersPage(),
      AdaptiveHistoryPage(),
      Orderpage(),
    ];
    return Row(
      children: [
        Navigation().navigationRail(context, provider),

        VerticalDivider(
          width: 1,
          thickness: 1,
          color: themecolor.outlineVariant,
        ),
        Expanded(
          child: Scaffold(
            key: provider.scaffoldkey,
            appBar: CustomAppBar(),
            body: pages[provider.selectedindex],
            floatingActionButton: FloatingCartButton(),
            endDrawer: Drawer(
              child: provider.iscart ? CartPage() : AccountDashboard(),
            ),
          ),
        ),
      ],
    );
  }
}

class Mobilescaffold extends StatelessWidget {
  final double width;
  const Mobilescaffold({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    // final theme=Theme.of(context).colorScheme;
    final provider = context.watch<NavigationProvider>();
    final List<Widget> pages = [
      Search(),
      UsersPage(),
      AdaptiveHistoryPage(),
      Orderpage(),
    ];
    return Scaffold(
      key: provider.scaffoldkey,
      appBar: CustomAppBar(),
      body: pages[provider.selectedindex],
      floatingActionButton: FloatingCartButton(),
      bottomNavigationBar: Navigation().bottomNavigation(context, provider),
      endDrawer: Drawer(
        width: width,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: provider.iscart ? CartPage() : AccountDashboard(),
      ),
    );
  }
}
