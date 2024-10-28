import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/layouts/grid_layout.dart';
import 'package:shopping_server/utils/popups/shimmers/default_shimmer.dart';

import '../../constants/sizes.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomShimmerEffect(
              width: 180,
              height: 140,
              radius: AppSize.cardRadiusLarge,
            ),
            SizedBox(height: AppSize.spaceBtwItems),
            CustomShimmerEffect(width: 120, height: 10),
            SizedBox(height: AppSize.small),
            CustomShimmerEffect(width: 60, height: 10),
            SizedBox(height: AppSize.small),
            CustomShimmerEffect(width: 70, height: 10),
          ],
        ),
      ),
    );
  }
}
