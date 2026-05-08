import 'dart:math';

import 'package:flutter/material.dart';

class Itembuilder<T> extends StatelessWidget {
  final Future<List<T>> future;
  final Widget? waitingWidget;
  final Widget Function(BuildContext, T) itemBuilder;

  final Widget? errorWidget;

  const Itembuilder({
    super.key,
    required this.future,
    this.waitingWidget,
    this.errorWidget,
    required this.itemBuilder,
  });

  Widget itembuilder(dynamic item, bool isloading) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final crossAxisCount = max(3, constraint.maxWidth ~/ 264);
        final skeletoncount = (constraint.maxWidth * 0.1).toInt();
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,

            mainAxisExtent: 160,
          ),
          itemCount: isloading ? skeletoncount : item.length,
          itemBuilder: (context, index) {
            return isloading
                ? waitingWidget
                : itemBuilder(context, item[index]);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: waitingWidget != null
                ? itembuilder(null, true)
                : const CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Center(
              child: errorWidget ?? Text(snapshot.error.toString()),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return itembuilder(snapshot.data!, false);
        }
        return const Center(child: Text('no item found'));
      },
    );
  }
}
