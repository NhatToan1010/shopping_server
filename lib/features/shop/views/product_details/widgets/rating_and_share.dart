import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/popups/loader.dart';

class RatingAndShare extends StatelessWidget {
  const RatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ===== Rating
        Wrap(
          spacing: AppSize.small,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(Icons.star_rounded, color: Colors.amber, size: 24),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '4.5 ', style: Theme.of(context).textTheme.bodyLarge),
                  const TextSpan(text: '(199)')
                ],
              ),
            ),
          ],
        ),

        // ===== Share Icon Button
        IconButton(
            onPressed: () => CustomLoader.customToast(message: 'Thank you for sharing this product.'),
            icon: const Icon(Icons.share, size: AppSize.iconMedium),
        ),
      ],
    );
  }
}
