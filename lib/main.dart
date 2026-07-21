import 'dart:async';

import 'package:chat_shop/src/core/syncer/auth_verify.dart';
import 'package:chat_shop/src/core/syncer/item_syncer.dart';
import 'package:chat_shop/src/core/layout/bloc/end_drawer_bloc.dart';
import 'package:chat_shop/src/core/widgets/loading_screen.dart';
import 'package:chat_shop/src/features/auth/cubit/auth_cubit.dart';

import 'package:chat_shop/src/features/auth/cubit/auth_states.dart';

import 'package:chat_shop/src/features/auth/ui/screen/verify_page.dart';
import 'package:chat_shop/src/features/cart/cubit/cart_cubit.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_bloc.dart';
import 'package:chat_shop/src/features/orders/bloc/order_bloc.dart';
import 'package:chat_shop/src/features/search/bloc/detail_cubit/detail_cubit.dart';
import 'package:chat_shop/src/features/search/bloc/searc_bloc/search_bloc.dart';

import 'package:chat_shop/src/features/search_users/bloc/search_user_block.dart';

import 'package:chat_shop/src/features/user_dashboard/cubit/user_cubit.dart';
import 'package:chat_shop/src/injecters.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:chat_shop/src/app.dart';

import 'package:chat_shop/src/features/auth/ui/screen/auth_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  await dotenv.load(fileName: 'ebuy_token.env');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependensies();
  await di.allReady();
  await di<ItemSyncer>().run();
  await di<AuthVerify>().run();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di<AuthCubit>()),
        BlocProvider(create: (_) => di<EndDrawerBloc>()),
        BlocProvider(create: (_) => di<UserDashboardCubit>()),
        BlocProvider(create: (_) => di<SearchBloc>()),
        BlocProvider(create: (_) => di<DetailCubit>()),
        BlocProvider(create: (_) => di<CartCubit>()),
        BlocProvider(create: (_) => di<SearchUserBloc>()),
        BlocProvider(create: (_) => di<OrderBloc>()),
        BlocProvider(create: (_)=>di<ChatBloc>())
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,

      home: BlocBuilder<AuthCubit, AuthStates>(
        builder: (context, state) {
          if (state is Authinitial) {
            return AuthScreen(error: null);
          } else if (state is Authloading) {
            return LoadingScreen();
          } else if (state is Authenticated) {
            return Home();
          } else if (state is AuthError) {
            return AuthScreen(error: state.error);
          } else if (state is NeedVerfication) {
            return VerifyPage(email: state.email);
          } else {
            return LoadingScreen();
          }
        },
      ),
    );
  }
}
