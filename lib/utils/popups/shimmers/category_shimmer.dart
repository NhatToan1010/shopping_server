import 'package:flutter/material.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/popups/shimmers/default_shimmer.dart';

class CategoryShimmerEffect extends StatelessWidget {
  const CategoryShimmerEffect({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(width: AppSize.small),
        itemBuilder: (_, __) => const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // ----- Image
            CustomShimmerEffect(width: 55, height: 55, radius: 80),
            SizedBox(height: AppSize.small),

            // ----- Text
            CustomShimmerEffect(width: 55, height: 8),
          ],
        ),
      ),
    );
  }
}
