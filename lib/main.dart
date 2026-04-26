import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:chat_shop/src/app.dart';
import 'package:chat_shop/src/core/layout/providers/appbar_provider.dart';
import 'package:chat_shop/src/core/layout/providers/navigation_provider.dart';
import 'package:chat_shop/src/features/auth/ui/provider/auth_provider.dart';
import 'package:chat_shop/src/features/auth/ui/screen/login_page.dart';
import 'package:chat_shop/src/features/cart/ui/providers/cart_provider.dart';
import 'package:chat_shop/src/features/chats/data/chat_repository.dart';
import 'package:chat_shop/src/features/chats/ui/providers/privider.dart';
import 'package:chat_shop/src/features/orders/ui/providers/order_provider.dart';
import 'package:chat_shop/src/features/search/ui/provider/bottomsheet_provider.dart';
import 'package:chat_shop/src/features/search/ui/provider/searchbar_provider.dart';
import 'package:chat_shop/src/features/search_users/ui/provider/search_user_provider.dart';
import 'package:chat_shop/src/features/user/ui/provider/provider.dart';

import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/*void _setupNativeThreadingBridge() {
  const platform = MethodChannel('com.chat_shop/auth');
  platform.setMethodCallHandler((call) async {
    if (call.method == "onAuthStateChanged") {
      debugPrint("✅ Thread-Safe: C++ Bridge confirmed Auth Update.");
    }
    if (call.method == "onFirebaseReady") {
      debugPrint("🚀 Thread-Safe: C++ Bridge confirmed Firebase Ready.");
    }
  });
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // _setupNativeThreadingBridge();
  await dotenv.load(fileName: 'ebuy_token.env');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final user = FirebaseAuth.instance.currentUser;
  if (user != null && !user.emailVerified) {
    await FirebaseAuth.instance.signOut();
  }

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<User?>(
          create: (_) => FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
        ProxyProvider<User?, ChatRepository>(
          update: (_, user, _) => ChatRepository(user),
        ),
        ChangeNotifierProvider(create: (_) => Userprovider(), lazy: false),
        ChangeNotifierProxyProvider<Userprovider, CartProvider>(
          create: (_) => CartProvider(null),
          update: (context, user, cart) {
            cart ??= CartProvider(user.userDomain);

            cart.user = user.userDomain;
            if (user.userDomain != null) {
              Future.microtask(() => cart?.init());
            }
            return cart;
          },
        ),
        ChangeNotifierProvider(create: (_) => Appbarprovider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => SearchbarProvider()),
        ChangeNotifierProvider(create: (_) => BottomsheetProvider()),

        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => Authprovider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => SearchUserProvider()),
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
