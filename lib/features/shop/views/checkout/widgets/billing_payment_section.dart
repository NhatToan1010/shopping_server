import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/images/circle_image.dart';
import 'package:shopping_server/common/widgets/texts/section_heading.dart';
import 'package:shopping_server/features/shop/controllers/products/payment_controller.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());

    return Column(
      children: [
        SectionHeading(
          title: 'Payment Methods',
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: AppSize.small),
        Obx(
          () => Row(
            children: [
              const SizedBox(width: AppSize.spaceBtwItems),
              CircleImage(
                width: 32,
                height: 32,
                imageUrl: controller.selectedPaymentMethod.value.image,
              ),
              const SizedBox(width: AppSize.spaceBtwItems),
              Text(
                controller.selectedPaymentMethod.value.name,
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        ),
      ],
    );
  }
}
