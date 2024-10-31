import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopping_server/features/shop/controllers/products/cart_controller.dart';
import 'package:shopping_server/features/shop/controllers/products/order_controller.dart';
import 'package:shopping_server/features/shop/views/cart/widgets/list_cart_item.dart';
import 'package:shopping_server/features/shop/views/checkout/widgets/billing_address_section.dart';
import 'package:shopping_server/features/shop/views/checkout/widgets/billing_amount_section.dart';
import 'package:shopping_server/features/shop/views/checkout/widgets/billing_payment_section.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/pricing_calculator.dart';

import '../../../../common/widgets/texts/textfields/coupon_textfield.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final orderController = Get.put(OrderController());
    final subTotal = cartController.totalPrice;
    final totalAmount =
        PricingCalculator.calculateTotalPrice(subTotal.value, 'US');

    return SafeArea(
      child: Scaffold(
        // ----- AppBar
        appBar: const CustomAppbar(
          title: Text('Order Review'),
          showBackArrow: true,
        ),
      
        // ----- Body
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSize.defaultSpace),
            child: Column(
              children: [
                // ----- List Order Item
                ListCartItem(showAddRemoveButton: false),
                SizedBox(height: AppSize.spaceBtwSections),
      
                // ----- Coupon TextField
                CouponTextField(),
                SizedBox(height: AppSize.spaceBtwSections),
      
                // ----- Billing Section
                RoundedContainer(
                  padding: EdgeInsets.all(AppSize.medium),
                  showBorder: true,
                  defaultBackgroundColor: true,
                  child: Column(
                    children: [
                      // ----- Pricing
                      BillingAmountSection(),
                      SizedBox(height: AppSize.spaceBtwItems),
      
                      // ----- Divider
                      Divider(),
                      SizedBox(height: AppSize.spaceBtwItems),
      
                      // ----- Payment Methods
                      BillingPaymentSection(),
                      SizedBox(height: AppSize.spaceBtwItems),
      
                      // ----- Address
                      BillingAddressSection(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      
        // ----- Bottom Navigation
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSize.medium, vertical: AppSize.small),
          child: ElevatedButton(
            onPressed: () => totalAmount > 0.0
                ? orderController.processOrder(totalAmount)
                : null,
            child: Text('Check Out \$$totalAmount'),
          ),
        ),
      ),
    );
  }
}
