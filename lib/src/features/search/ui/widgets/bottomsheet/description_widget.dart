import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  final String? description;
  final ValueNotifier<bool> isExpanded;
  final VoidCallback onpressed;
  const DescriptionWidget({
    super.key,
    required this.description,
    required this.isExpanded,
    required this.onpressed,
  });

  Widget _description(bool isexpaned) {
    return AnimatedCrossFade(
      firstChild: _text(isexpaned,),
      secondChild: _text(isexpaned),
      crossFadeState: isexpaned
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }

  Widget _text(bool isexpaned, ) {
    final text = description!.length > 100
        ? '${description!.substring(0, 100)}..'
        : description;
    return RichText(
      text:TextSpan(style: TextStyle(color: Colors.black,),
        text: isexpaned ? description : text,
        children: [
          WidgetSpan(
            child: description!.length>100? InkWell(borderRadius: BorderRadius.all(const Radius.circular(6)),
              onTap: onpressed,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(style: TextStyle(color: Colors.blue,fontSize: 12),
                  isexpaned ? 'Read Less' : 'Read More'),
              ),
            ):const SizedBox.shrink(),
          ),
        ],
      ),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return description==null?const SizedBox.shrink() :ValueListenableBuilder(
      valueListenable: isExpanded,
      builder: (context, value, child) {
        return _description(value);
      },
    );
  }
}
