import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class CustomSearchbar extends StatelessWidget {
  final void Function() onSearch;
  final TextEditingController textFieldcontroller;
  final void Function() onremove;
  final String? hintText;
  final List<String>? animatedHints;
  final ValueNotifier<String>? iscategory;

  const CustomSearchbar({
    super.key,
    this.iscategory,

    required this.onSearch,
    required this.textFieldcontroller,
    this.hintText,
    this.animatedHints,
    required this.onremove,
  });

  Widget searchIcon() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: IconButton(onPressed: onSearch, icon: const Icon(Icons.search)),
    );
  }

  Widget animatedHintsWidget() {
    return ListenableBuilder(
      listenable: Listenable.merge([textFieldcontroller, iscategory!]),
      builder: (context, child) {
        if (textFieldcontroller.text.isEmpty &&
            iscategory!.value.isEmpty &&
            animatedHints != null) {
          return Padding(
            padding: const EdgeInsets.only(left: 75),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.grey, fontSize: 14),
              child: StreamBuilder(
                stream: Stream.periodic(
                  const Duration(seconds: 3),
                  (count) => count,
                ),
                builder: (context, snapshot) {
                  final index = snapshot.data ?? 0;
                  final hints = animatedHints![index % animatedHints!.length];
                  return AnimatedTextKit(
                    key: ValueKey(index),
                    repeatForever: false,
                    pause: const Duration(seconds: 1),

                    animatedTexts: [
                      TypewriterAnimatedText(
                        hints,
                        speed: const Duration(milliseconds: 100),
                        cursor: '|',
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget textfield() {
    return Expanded(
      child: Stack(
        alignment: .centerLeft,
        children: [
          animatedHintsWidget(),

          ValueListenableBuilder(
            valueListenable: iscategory!,
            builder: ((context, value, child) {
              return TextField(
                controller: textFieldcontroller,
                onSubmitted: (value) => onSearch(),
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText:value.isEmpty? hintText :value,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget removebutton() {
    return ListenableBuilder(
      listenable: Listenable.merge([textFieldcontroller, iscategory!]),
      builder: (context, child) {
        if (textFieldcontroller.text.isNotEmpty ||
            (iscategory!.value.isNotEmpty)) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              onPressed: onremove,
              icon: const Icon(Icons.close),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(const Radius.circular(16)),
          color: Colors.grey.withValues(alpha: 0.2),
        ),
        child: Row(children: [searchIcon(), textfield(), removebutton()]),
      ),
    );
  }
}
