import 'package:flutter/material.dart';

abstract class EndDrawerEvents {}

class OnTapCart extends EndDrawerEvents {
  final GlobalKey<ScaffoldState> scaffoldkey;
  OnTapCart(this.scaffoldkey);
}

class OnTapAccountDasboard extends EndDrawerEvents {
   final GlobalKey<ScaffoldState> scaffoldkey;
  OnTapAccountDasboard(this.scaffoldkey);
}
