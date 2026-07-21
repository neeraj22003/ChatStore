import 'dart:math';

import 'package:flutter/material.dart';

class Itembuilder<T> extends StatelessWidget {
  final List<T>? items;
  final bool isloading;

  final Widget? waitingWidget;
  final Widget Function(BuildContext, T)? itemBuilder;
  final int? mincount;
  final Widget? errorWidget;
  final int? truncatedevidecountvalue;
  final ScrollPhysics? physics;
  final double? mainaxisextent;
  const Itembuilder({
    super.key,
    this.physics,
    this.items,
    this.mincount,
    this.mainaxisextent,
    this.truncatedevidecountvalue,
    this.isloading = false,
    this.waitingWidget,
    this.errorWidget,
    this.itemBuilder,
  });

  Widget grid(List<T> data, bool loading) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final crossAxisCount = max(
          mincount ?? 3,
          constraint.maxWidth ~/ (truncatedevidecountvalue ?? 264),
        );
        final skeletoncount = (constraint.maxWidth * 0.02).toInt();
        return GridView.builder(
          shrinkWrap: true,
          physics: physics,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,

            mainAxisExtent: mainaxisextent??160,
          ),
          itemCount: isloading ? skeletoncount : data.length,
          itemBuilder: (context, index) {
            return loading ? waitingWidget : itemBuilder!(context, data[index]);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isloading) return grid([], true);

    if (items!.isEmpty) return const Center(child: Text('no item found'));
    return grid(items!, false);
  }
}
