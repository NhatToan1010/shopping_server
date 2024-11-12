
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/screen_widgets/success_screen.dart';
import 'package:shopping_server/data/repositories/authentication_repository.dart';
import 'package:shopping_server/data/repositories/order_repository.dart';
import 'package:shopping_server/features/personalization/controllers/address_controller.dart';
import 'package:shopping_server/features/shop/controllers/products/cart_controller.dart';
import 'package:shopping_server/features/shop/controllers/products/payment_controller.dart';
import 'package:shopping_server/features/shop/models/order_model.dart';
import 'package:shopping_server/features/shop/views/navigation_menu.dart';
import 'package:shopping_server/utils/constants/enums.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';
import 'package:shopping_server/utils/popups/full_screen_loader.dart';
import 'package:shopping_server/utils/popups/loader.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final orderRepository = Get.put(OrderRepository());
  final cartController = CartController.instance;
  // Lay du lieu
  final paymentController = PaymentController.instance;
  final addressController = AddressController.instance;

  // --- Get All Order Data
  Future<List<OrderModel>> getAllUserOrder() async {
    try {
      // Lấy các dữ liệu từ trường 'Orders' của người dùng từ Server về Client
      final orders = await orderRepository.fetchAllUserOrder();

      return orders;
    } catch (e) {
      CustomLoader.errorSnackBar(
        title: 'Order Controller Error!',
        message: e.toString(),
      );
      return [];
    }
  }

  // --- Add method for order processing
  Future<void> processOrder(double totalAmount) async {
    try {
      // Lấy các dữ liệu về sản phẩm trong giỏ hàng, địa chỉ, và PTTT chuyển thành dạng OrderModel
      // Từ OrderModel client sẽ chuyển data lên CSDL của người dùng hiện tại.
      // (CartModel, Address, Payment) => OrderModel => Database(UID, OrderModel)
      FullScreenLoader.openLoadingDialog('Processing Your Order...', LocalImages.loading);

      // --- Try to find user id
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        return CustomLoader.errorSnackBar(
          title: 'Order Controller Error!',
          message: 'Unable to find user.',
        );
      }

      // --- If user id found, then create new order
      // Nếu tìm thấy id người dùng thì tạo mới một OrderModel
      final newOrder = OrderModel(
        // Creates a key that is equal only to itself.
        id: UniqueKey().toString(),
        userId: userId,
        paymentMethod: paymentController.selectedPaymentMethod.value.name,
        deliveryAddress: addressController.selectedAddress.value,
        totalAmount: totalAmount,
        orderStatus: OrderStatus.pending,
        orderDate: DateTime.now(),
        itemsPurchase: cartController.cartItems.toList(),
        deliveryDate: DateTime.now(),
      );

      // Save order to Database
      // Lưu dữ liệu vừa tạo vào CSDL của người dùng tương ứng
      await orderRepository.saveOrder(newOrder, userId);

      // Update the cart status
      // Làm rỗng giỏ hàng
      cartController.clearCart();

      FullScreenLoader.stopLoading();

      // Move to Success Screen
      // Đi đến màn hình thông báo thành công
      await Get.offAll(
        () => SuccessScreen(
          title: 'Order Created!',
          subtitle:
              'Congratulations! Your order has been created. '
                  'We will announce when the products arrive at your place.',
          image: LocalImages.emailVerification2,
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ),
      );

    } catch (e) {
      CustomLoader.errorSnackBar(
        title: 'Order Controller Error!',
        message: e.toString(),
      );
      FullScreenLoader.stopLoading();
    } finally {
      FullScreenLoader.stopLoading();
    }
  }
}
