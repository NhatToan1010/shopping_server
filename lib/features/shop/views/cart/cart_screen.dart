import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/features/shop/controllers/products/cart_controller.dart';
import 'package:shopping_server/features/shop/views/cart/widgets/list_cart_item.dart';
import 'package:shopping_server/features/shop/views/checkout/checkout_screen.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return SafeArea(
      child: Scaffold(
        // ----- AppBar
        appBar: const CustomAppbar(
          title: Text('Cart'),
          showBackArrow: true,
        ),
      
        // *-----* Body
        body: Obx(
          () {
            return controller.cartItems.isEmpty
                ? Center(child: Text('No Item Found!', style: Theme.of(context).textTheme.labelMedium),)
                : const SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(AppSize.defaultSpace),
                      child: ListCartItem(),
                    ),
                  );
          },
        ),

        // *====*
        bottomNavigationBar: controller.cartItems.isEmpty ? const SizedBox() : Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSize.medium,
              vertical: AppSize.small,
          ),
          child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            child: Text('Checkout \$${controller.totalPrice.value}'),
          ),
        ),
      ),
    );
  }
}
