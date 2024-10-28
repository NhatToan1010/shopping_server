import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/texts/section_heading.dart';
import 'package:shopping_server/features/shop/models/payment_model.dart';
import 'package:shopping_server/features/shop/views/checkout/widgets/payment_selection.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

class PaymentController extends GetxController {
  static PaymentController get instance => Get.find();

  Rx<PaymentModel> selectedPaymentMethod = PaymentModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    selectedPaymentMethod.value = PaymentModel(
      name: 'Paypal',
      image: LocalImages.paypal,
    );
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.medium),
        child: Column(
          children: [
            // --- Title
            const SectionHeading(title: 'Select Payment Method', showActionButton: false),
            const SizedBox(height: AppSize.spaceBtwSections),

            // --- Payment Methods
            PaymentSelection(paymentMethod: PaymentModel(name: 'Paypal', image: LocalImages.paypal)),
            const SizedBox(height: AppSize.small),
            PaymentSelection(paymentMethod: PaymentModel(name: 'Visa', image: LocalImages.visa)),
            const SizedBox(height: AppSize.small),
            PaymentSelection(paymentMethod: PaymentModel(name: 'Master Card', image: LocalImages.masterCard)),
            const SizedBox(height: AppSize.small),
            PaymentSelection(paymentMethod: PaymentModel(name: 'Google Pay', image: LocalImages.googlePay)),
            const SizedBox(height: AppSize.small),
            PaymentSelection(paymentMethod: PaymentModel(name: 'Apple Pay', image: LocalImages.applePay)),
            const SizedBox(height: AppSize.small),
          ],
        ),
      ),
    );
  }
}
