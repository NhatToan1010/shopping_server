import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/common/widgets/icons/circular_icon.dart';
import 'package:shopping_server/common/widgets/layouts/grid_layout.dart';
import 'package:shopping_server/common/widgets/product_cart/product_cards/product_card_vertical.dart';
import 'package:shopping_server/data/dummy_data.dart';
import 'package:shopping_server/features/shop/views/home/home_screen.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: const Text('Wishlist'),
        actions: [CircularIcon(icon: Icons.add, onPressed: () => Get.to(() => const HomeScreen()))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: GridLayout(
            mainAxisExtent: AppSize.productVerticalAxisExtent,
            itemCount: 8,
            itemBuilder: (_, index) => ProductCardVertical(productIndex: DummyData.products[index],),
          ),
        ),
      ),
    );
  }
}
