import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//import 'package:flutter_experiments/auth/signup/verify_page.dart';

import 'package:flutter_experiments/features/auth/ui/provider/auth_provider.dart';
import 'package:flutter_experiments/features/auth/ui/screen/login_page.dart';
import 'package:flutter_experiments/features/search/ui/provider/bottomsheet_provider.dart';
import 'package:flutter_experiments/features/search/ui/provider/searchbar_provider.dart';
import 'package:flutter_experiments/home.dart';
import 'package:flutter_experiments/features/user/ui/provider/provider.dart';
import 'package:flutter_experiments/features/chats_history/ui/providers/privider.dart';

import 'package:flutter_experiments/features/cart/ui/providers/cart_provider.dart';

import 'package:flutter_experiments/core/layout/providers/navigation_provider.dart';
import 'package:flutter_experiments/core/layout/providers/appbar_provider.dart';
import 'package:flutter_experiments/features/orders/ui/providers/order_provider.dart';

import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'ebuy_token.env');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Appbarprovider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => SearchbarProvider()),
        ChangeNotifierProvider(create: (_) => BottomsheetProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => Authprovider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => Userprovider(), lazy: false),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer2<Appbarprovider, Authprovider>(
      builder: (context, appbarprovider, auth, child) {
        return MaterialApp(
          scaffoldMessengerKey: auth.snacbarkey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.lightBlueAccent,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.lightBlueAccent,
            brightness: Brightness.dark,
          ),
          themeMode: appbarprovider.thememode,

          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data == null) {
                return LoginPage();
              }
              return Home();
            },
          ),
        );
      },
    );
  }
}
