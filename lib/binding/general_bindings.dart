import 'package:get/get.dart';
import 'package:shopping_server/features/personalization/controllers/address_controller.dart';
import 'package:shopping_server/features/shop/controllers/products/payment_controller.dart';
import 'package:shopping_server/features/shop/controllers/products/product_variation_controller.dart';
import 'package:shopping_server/utils/network/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(ProductVariationController());
    Get.put(AddressController());
    Get.put(PaymentController());
  }
}