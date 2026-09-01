import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final double? size;
  final ValueNotifier<int>? yourCountervalue;
  final Widget? trailing;

  const CounterWidget({
    super.key,
    this.onIncrement,
    this.size,
    this.yourCountervalue,
    this.onDecrement,
    this.trailing,
  });

  Widget addbutton() {
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: IconButton(onPressed: onIncrement, icon: const Icon(Icons.add)),
    );
  }

  Widget subutton() {
    return Padding(
      padding: const EdgeInsets.only(right: 2),
      child: IconButton(onPressed: onDecrement, icon: const Icon(Icons.remove)),
    );
  }

  Widget numcontainer(ColorScheme colorScheme) {
    return ValueListenableBuilder(
      valueListenable: yourCountervalue ?? ValueNotifier(0),
      builder: (context, value, child) =>Container(
        height: size??25,
        width: size??25,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.all(const Radius.circular(2)),
        ),
        child: Center(child: Text(value.toString())),
        
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SafeArea(child: onDecrement != null || onIncrement != null
        ? Row(
            mainAxisSize: .min,
            children: [
              subutton(),
              numcontainer(color),
              addbutton(),
              trailing != null ? Spacer() : const SizedBox.shrink(),
              trailing == null ? const SizedBox.shrink() : trailing!,
            ],
          )
        :Row(mainAxisSize: .min, children: [ numcontainer(color)]));
  }
}
