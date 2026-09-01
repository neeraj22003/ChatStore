import 'package:flutter/material.dart';

class SenderRow extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  const SenderRow({super.key, required this.controller, required this.onSend});

  Widget sendbutton(ColorScheme color) {
    bool isdark = color.brightness == Brightness.dark;
    return IconButton(
      
      onPressed: onSend,

      icon: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, child) {
          return Icon(
            shadows: (value.text.isNotEmpty && isdark)
                ? [
                    BoxShadow(
                      color: const Color.fromARGB(255, 66, 255, 255),
                      spreadRadius: 10,
                      blurRadius: 10,
                    ),
                  ]
                : [],
            Icons.send_rounded,
            size: 30,
            color: value.text.trim().isEmpty
                ? color.secondary
                : isdark
                ? Colors.white
                : Color(0xFF4169E1),
          );
        },
      ),
    );
  }

  Widget textfield(
    ColorScheme color,
   
  ) {
    return Material(
      elevation: 6,
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      color: color.surfaceBright,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: TextField(
          controller: controller,
          onSubmitted:(v)=>onSend()
                ,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Message',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
   
        return SafeArea(child: Padding(
          padding: const EdgeInsets.only(bottom: 8,left: 10,),
          child: Row(
           
            children: [
              Expanded(child: textfield(color,)),
              sendbutton(color, ),
            ],
          ),
        ));
      
    
  }
}
