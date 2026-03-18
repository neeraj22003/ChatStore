import 'package:flutter/material.dart';

class Header extends StatelessWidget{
  const Header({super.key});

  @override
  Widget build(BuildContext context){
    final width=MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: Container(
      height: width>600?200:150,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(7),
          bottomLeft: Radius.circular(7)
        ),
        image: DecorationImage(
          //colorFilter:ColorFilter.mode(Colors.pink, BlendMode.color) ,
          fit:BoxFit.cover,
          image:AssetImage('assets/header.jpg'),
          ),
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(7),
          bottomRight: Radius.circular(7)
        ),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.transparent
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter
        )
      ),

    )
   );

  }
}