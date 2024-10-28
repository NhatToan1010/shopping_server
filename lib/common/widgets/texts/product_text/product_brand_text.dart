import 'package:flutter/material.dart';


class ProductBrandText extends StatelessWidget {
  const ProductBrandText({
    super.key,
    required this.brandName,
    this.smallSize = true,
    this.showIcon = true,
    this.maxLines = 1,
    this.textAlign = TextAlign.start ,
  });

  final String brandName;
  final bool smallSize, showIcon;
  final int maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '$brandName ',
              textAlign: textAlign,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: smallSize
                  ? Theme.of(context).textTheme.labelLarge
                  : Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
