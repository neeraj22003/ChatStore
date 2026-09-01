import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String errorTitle;
  final  void Function() onTap;
  final void Function() onCancel;
  final ValueNotifier<String> errorNotifier;
  const ErrorDialog({
    super.key,
    required this.onTap,
    required this.onCancel,
    required this.errorNotifier,
    required this.errorTitle,
  });
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: errorNotifier,
      builder: (context, value, child) {
        if (value.isNotEmpty) {
          return GestureDetector(
            onTap: (){},
            child: Container(
              decoration: BoxDecoration(color: Colors.black54),
              child: AlertDialog(
                title: Text(errorTitle,),

                content: Text(value,style: TextStyle(fontSize: 13),),
                actions: [
                  TextButton(onPressed: onCancel, child: Text("Cancel")),
                  TextButton(onPressed: onTap, child: Text('Retry'))],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
