import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 300),
            CircularProgressIndicator(strokeWidth: 5),
            const SizedBox(height: 5),
            Text('Loading', style: TextStyle(fontSize: 25)),
          ],
        ),
      ),
    );
  }
}
