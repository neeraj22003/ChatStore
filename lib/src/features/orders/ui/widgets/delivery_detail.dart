import 'package:flutter/material.dart';

class DeliveryDetail extends StatelessWidget {
  final List<DeliveryEntery> detail;
  final double spacing;
  const DeliveryDetail({
    super.key,
    required this.detail,
    required this.spacing,
  });

  Widget _detailwidget(
    String text1,
    String? text2,
    double width,
    Icon icon,
  ) {
    return Row(
      children: [
        icon,
        SizedBox(width: spacing),

        Expanded(
          child: ListTile(
            title: Text(
              text1,
              style: TextStyle(fontSize: width < 200 ? 7 : 15),
            ),
            subtitle: text2 != null
                ? Text(
                    text2,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: width < 200 ? 7 : 15),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            children: detail
                .map(
                  (data) => _detailwidget(
                    data.title,
                    data.subtitle,
                    constraints.maxWidth,
                    data.icon,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

class DeliveryEntery {
  final Icon icon;
  final String title;
  final String? subtitle;
  DeliveryEntery(this.icon, this.title, this.subtitle);
}
