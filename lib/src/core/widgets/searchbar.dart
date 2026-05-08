
import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomSearchbar extends StatefulWidget {
  final void Function() onSearch;
  final TextEditingController textFieldcontroller;
  final void Function() onremove;
  final String? hintText;
  final List<String> animatedHints;
  final ValueListenable<bool>? iscategoryactive;

  const CustomSearchbar({
    super.key,
    this.iscategoryactive,
    required this.onSearch,
    required this.textFieldcontroller,
    required this.hintText,
    required this.animatedHints,
    required this.onremove,
  });

  @override
  State<CustomSearchbar> createState() => _CustomSearchbarState();
}

class _CustomSearchbarState extends State<CustomSearchbar> {
  
  int _index = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _index = (_index + 1) % widget.animatedHints.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget searchIcon() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: IconButton(
        onPressed: widget.onSearch,
        icon: const Icon(Icons.search),
      ),
    );
  }

  Widget animatedHints() {
    return ValueListenableBuilder(
      valueListenable: widget.textFieldcontroller,
      builder: (context, value, child) {
        if (value.text.isEmpty && !(widget.iscategoryactive?.value??false)) {
          return Padding(
            padding: const EdgeInsets.only(left: 80),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.grey, fontSize: 14),
              child: AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(seconds: 1),

                animatedTexts: widget.animatedHints
                    .map(
                      (hints) => TypewriterAnimatedText(
                        '"$hints"',
                        speed: const Duration(milliseconds: 100),
                        cursor: '|',
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget textfield() {
    return Expanded(
      child: Stack(
        alignment: .centerLeft,
        children: [
          animatedHints(),
          TextField(
            controller: widget.textFieldcontroller,
            onSubmitted: (value) => widget.onSearch(),
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: widget.hintText ?? 'Search For',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget removebutton() {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: widget.textFieldcontroller,
      builder: (context, value, child) {
        return value.text.isNotEmpty ||
                (widget.iscategoryactive?.value ?? false)
            ? Padding(
                padding: const EdgeInsets.all(5.0),
                child: IconButton(
                  onPressed: widget.onremove,
                  icon: const Icon(Icons.close),
                ),
              )
            : const SizedBox.shrink();
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
          color: Colors.grey.withOpacity(0.2),
        ),
        child: Row(children: [searchIcon(), textfield(), removebutton()]),
      ),
    );
  }
}

