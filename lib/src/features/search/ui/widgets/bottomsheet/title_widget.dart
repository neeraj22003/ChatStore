import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String? title;
  const TitleWidget({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
     return  Center(
      child: Text(
       title?.split(" ").take(3).join(" ")??'',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
