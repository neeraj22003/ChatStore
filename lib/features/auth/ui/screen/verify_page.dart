import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_experiments/core/services/images.dart';
import 'package:flutter_experiments/features/auth/data/auth_repository.dart';
import 'package:flutter_experiments/features/auth/ui/provider/auth_provider.dart';
import 'package:flutter_experiments/features/user/ui/provider/provider.dart';

import 'package:provider/provider.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  void initState() {
    super.initState();

    context.read<Authprovider>().startVerificationPolling(
      context.read<Userprovider>(),
    );
  }

  Widget message(BuildContext context) {
    final user = context.read<Authprovider>();
    return Text(
      'We’ve sent a verification link to your email ${user.user?.email}. '
      'Please check your inbox or "spam" folder and verify before continuing.',
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    );
  }

  Widget indicator() {
    return Consumer<Authprovider>(
      builder: (context, provider, child) {
        if (provider.verified) {
          Future.delayed(const Duration(seconds: 3), () {
            if (context.mounted && Navigator.canPop(context)) {
              Navigator.pop(context);
              // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home()));
            }
          });
          return const Icon(Icons.task_alt, color: Colors.green, size: 50);
        }
        return const LinearProgressIndicator();
      },
    );
  }

  Widget messageBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              message(context),
              const SizedBox(height: 20),
              indicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget cancelButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        context.read<Authprovider>().stopVerificationPolling();
        await AuthRepository(FirebaseAuth.instance).cancelverification(context);

        if (!context.mounted) return;
        Navigator.pop(context);
      },
      child: const Text('Cancel'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250, child: Image.asset(ImageService.email)),
              const SizedBox(height: 18),
              messageBox(context),
              const SizedBox(height: 18),
              cancelButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
