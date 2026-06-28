import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  final String? error;
  const ErrorBox({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return error != null&&error!.isNotEmpty
        ? Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(error!),
                  ),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
