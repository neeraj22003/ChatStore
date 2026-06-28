import 'package:chat_shop/src/features/auth/cubit/auth_cubit.dart';

import 'package:chat_shop/src/features/auth/cubit/auth_states.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';
import 'package:flutter/material.dart';
import 'package:chat_shop/src/core/services/images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPage extends StatefulWidget {
  final String email;

  const VerifyPage({super.key, required this.email});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  void initState() {
    super.initState();

    context.read<AuthCubit>().onStartverification();
  }

  Widget message(BuildContext context) {
    return Text(
      'We’ve sent a verification link to your email ${widget.email}. '
      'Please check your inbox or "spam" folder and verify before continuing.',
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    );
  }

  Widget indicator() {
    final isSuccess = context.read<AuthCubit>().isSuccess;
    return ValueListenableBuilder(
      valueListenable: isSuccess,
      builder: (context, isSuccess, child) {
        if (isSuccess) {
          return const Icon(Icons.task_alt, color: Colors.green, size: 50);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget messageBox() {
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

  Widget cancelButton() {
    return TextButton(
      onPressed: () async {
        await context.read<AuthCubit>().onTapCancel();
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
              messageBox(),
              const SizedBox(height: 18),
              cancelButton(),
            ],
          ),
        ),
      ),
    );
  }
}
