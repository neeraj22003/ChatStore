import 'package:flutter/material.dart';
import 'package:chat_shop/src/core/layout/scaffold.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  //int _selectedindex=0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 480) {
          return WideScaffolds();
        } else {
          return Mobilescaffold(width: constraints.maxWidth);
        }
      },
    );
  }
}
