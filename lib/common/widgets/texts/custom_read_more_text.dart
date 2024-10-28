import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CustomReadMoreText extends StatelessWidget {
  const CustomReadMoreText({
    super.key, required this.content, required this.trimLines,
  });

  final String content;
  final int trimLines;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      textAlign: TextAlign.start,
      content,
      trimLines: trimLines,
      trimMode: TrimMode.Line,
      trimCollapsedText: ' Show more',
      trimExpandedText: ' Less',
      moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }
}
