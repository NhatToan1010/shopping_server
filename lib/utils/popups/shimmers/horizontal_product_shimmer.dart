import 'package:flutter/material.dart';

import '../../../common/widgets/layouts/grid_layout.dart';
import '../../constants/sizes.dart';
import 'default_shimmer.dart';

class HorizontalProductShimmerEffect extends StatelessWidget {
  const HorizontalProductShimmerEffect({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomShimmerEffect(
              width: 60,
              height: 60,
              radius: AppSize.cardRadiusLarge,
            ),
            SizedBox(width: AppSize.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimmerEffect(width: 80, height: 10),
                SizedBox(height: AppSize.small),
                CustomShimmerEffect(width: 60, height: 10),
                SizedBox(height: AppSize.small),
                CustomShimmerEffect(width: 50, height: 10),
              ],
            )
          ],
        ),
      ),
    );
  }
}
