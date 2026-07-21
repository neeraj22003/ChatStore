import 'package:flutter/material.dart';

class Customoutlinebutton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? color;
  final double? height;
  final double? width;
  final double? borderradius;
  final double? fontsize;
  const Customoutlinebutton({
    super.key,
    this.height,
    this.width,
    this.borderradius,
    this.fontsize,
    required this.onPressed,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return borderradius!=null? 
     
     OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.all(Radius.circular(borderradius??0)),
          ),
          side: BorderSide(color: color ?? Colors.transparent, width: 2),
          backgroundColor: color,
        ),

        onPressed: onPressed,
        child: SizedBox(
          height: height,
          width: width,
          child: Center(child: Text(text, style: TextStyle(color: Colors.white,fontSize:fontsize))),
        ),
      
    ): 
     
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          
          side: BorderSide(color: color ?? Colors.transparent, width: 2),
          backgroundColor: color,
        ),

        onPressed: onPressed,
        child: SizedBox(
          height: height,
          width: width,
          child: Center(child: Text(text, style: TextStyle(color: Colors.white,fontSize:fontsize ))),
        ),
      
    );
  }
}

  

