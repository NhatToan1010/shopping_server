import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/layouts/grid_layout.dart';
import 'package:shopping_server/utils/popups/shimmers/default_shimmer.dart';

class BrandShimmerEffect extends StatelessWidget {
  const BrandShimmerEffect({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const CustomShimmerEffect(width: 300, height: 80),
    );
  }
}
