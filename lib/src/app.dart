import 'package:chat_shop/src/core/layout/bloc/end_drawer_bloc.dart';
import 'package:chat_shop/src/core/layout/bloc/end_drawer_events.dart';
import 'package:chat_shop/src/core/layout/bloc/end_drawer_state.dart';
import 'package:chat_shop/src/core/layout/notfiers/notifiers.dart';
import 'package:chat_shop/src/features/cart/cubit/cart_cubit.dart';
import 'package:chat_shop/src/features/cart/cubit/cart_state.dart';
import 'package:chat_shop/src/features/cart/ui/screen/cart_page.dart';

import 'package:chat_shop/src/core/widgets/cart_button.dart';
import 'package:chat_shop/src/features/chat_history/ui/screen/histor_page.dart';
import 'package:chat_shop/src/features/orders/ui/screen/orderpage.dart';
import 'package:chat_shop/src/features/search/ui/screen/search_page.dart';
import 'package:chat_shop/src/features/search_users/ui/screen/users_page.dart';
import 'package:chat_shop/src/features/user_dashboard/ui/screen/acount_dashboard.dart';
import 'package:chat_shop/src/injecters.dart';
import 'package:flutter/material.dart';
import 'package:chat_shop/src/core/layout/scaffold/adaptive_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final List<Widget> pages = [Search(), UsersPage(), HistorPage(), Orderpage()];


  final List<NavigationList> navigaitonlist = [
    NavigationList(icon: Icons.home, title: 'Home'),
    NavigationList(icon: Icons.search, title: 'Search User'),
    NavigationList(icon: Icons.chat, title: 'Chat'),
    NavigationList(icon: Icons.shopping_bag, title: 'Order'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomAdaptiveLayout(
      navigtionlist: navigaitonlist,
      scaffoldstatekey: scaffoldkey,
      appbar: AppBar(
        elevation: 12,
        actions: [
          IconButton(
            onPressed: () {
              context.read<EndDrawerBloc>().add(
                OnTapAccountDasboard(scaffoldkey),
              );
              
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      pages: ValueListenableBuilder(
        valueListenable: di<Not>().navigationIndex,
        builder: (context, value, child) {
          return pages[value];
        },
      ),
      onNavigationTap: (index) {
        di<Not>().navigationIndex.value = index!;
      },
     selectedIndex:di<Not>().navigationIndex ,
      endDrawer: SizedBox(
        height: 600,
        child: Drawer(
          child: BlocBuilder<EndDrawerBloc, EndDrawerState>(
            builder: (context, state) {
              if (state is IsCart) {
                return CartPage(cartlength: state.length, user: state.user);
              } else if (state is IsAcountDasboard) {
                return AccountDashboard();
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
      floatingactionButton: ValueListenableBuilder(
        valueListenable: di<Not>().navigationIndex,
        builder: (context, value, child) {
          if (value < 1) {
            return BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is Cartloaded) {
                  return CartButton(
                    ontap: () {
                      context.read<EndDrawerBloc>().add(OnTapCart(scaffoldkey));
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
              
            );
          }
          return  const SizedBox.shrink();
        },
      ),
    );
  }
}
