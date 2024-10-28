import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/texts/product_text/product_price_text.dart';
import 'package:shopping_server/features/shop/controllers/products/cart_controller.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/pricing_calculator.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final subTotal = controller.totalPrice.value;
    final shippingFee = PricingCalculator.calculateShippingCost('US');
    final taxFee = PricingCalculator.calculateTax(subTotal, 'US');
    final totalOrder = PricingCalculator.calculateTotalPrice(subTotal, 'US');
    
    return Column(
      children: [
        // ----- SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('SubTotal', style: Theme.of(context).textTheme.labelLarge,),
            ProductPriceText(price: subTotal.toString(), isLarge: false,)
          ],
        ),
        const SizedBox(height: AppSize.small),

        // ----- Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.labelLarge,),
            ProductPriceText(price: shippingFee, isLarge: false,)
          ],
        ),
        const SizedBox(height: AppSize.small),

        // ----- Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.labelLarge,),
            ProductPriceText(price: taxFee, isLarge: false,)
          ],
        ),
        const SizedBox(height: AppSize.small),

        // ----- Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.titleLarge,),
            ProductPriceText(price: totalOrder.toString(),)
          ],
        ),
      ],
    );
  }
}
