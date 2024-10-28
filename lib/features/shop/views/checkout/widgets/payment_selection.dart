import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/images/rounded_rect_image.dart';
import 'package:shopping_server/features/shop/controllers/products/payment_controller.dart';
import 'package:shopping_server/features/shop/models/payment_model.dart';

class PaymentSelection extends StatelessWidget {
  const PaymentSelection({super.key, required this.paymentMethod});

  final PaymentModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = PaymentController.instance;

    return ListTile(
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },

      leading: RoundedRectImage(
        imageUrl: paymentMethod.image,
        width: 32,
        height: 32,
      ),

      title: Text(
        paymentMethod.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),

      trailing: const Icon(Icons.navigate_next_rounded),
    );
  }
}
