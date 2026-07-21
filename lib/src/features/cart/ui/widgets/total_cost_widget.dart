import 'package:flutter/widgets.dart';

class TotalCostWidget extends StatelessWidget {
  final ValueNotifier<double> totalcost;
  final double textsize;
  final double costsize;
  final double? padding;
  const TotalCostWidget({
    super.key,
    this.padding,
    required this.totalcost,
    required this.textsize,
    required this.costsize,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(padding??0),
      child: ValueListenableBuilder(
        valueListenable: totalcost,
        builder: (context, value, child) {
          return Row(
            mainAxisSize: .min,
            mainAxisAlignment: .end,
            children: [
              Flexible(child: Text('Total: ₹', style: TextStyle(fontSize: textsize),overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,)),
              
                Flexible(
                  child: Text(maxLines: 1,
                    value.toStringAsFixed(1),
                    style: TextStyle(fontWeight: .w500, fontSize: costsize,),
                    overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  textAlign: TextAlign.end,
                 ),
                ),
            ],
          );
        },
      ),
    );
  }
}
