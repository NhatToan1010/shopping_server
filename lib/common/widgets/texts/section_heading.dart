import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = true,
    required this.title,
    this.buttonTitle = 'View all',
    this.onPressed, this.maxLines = 1,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final VoidCallback? onPressed;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .apply(color: textColor),
          textAlign: TextAlign.start,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.end,
            ),
          ),
      ],
    );
  }
}
