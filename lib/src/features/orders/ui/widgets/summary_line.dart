import 'package:flutter/material.dart';

class SummaryLine extends StatelessWidget {
  final List<SummaryEntry> summaryEntry;
  const SummaryLine({super.key, required this.summaryEntry});

  Widget _row(String text1, String text2, double width) {
    return Row(
      children: [
        Text(text1, style: TextStyle(fontSize: width < 220 ? 7 : 14)),
        Spacer(),
        Text('₹$text2', style: TextStyle(fontSize: width < 220 ? 7 : 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          return Wrap(
            children: summaryEntry
                .map((data) => _row(data.text1, data.text2, width))
                .toList(),
          );
        },
      ),
    );
  }
}

class SummaryEntry {
  final String text1;
  final String text2;
  SummaryEntry(this.text1, this.text2);
}
