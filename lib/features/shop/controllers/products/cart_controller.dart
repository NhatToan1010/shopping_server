import 'package:get/get.dart';
import 'package:shopping_server/data/repositories/product_repository.dart';
import 'package:shopping_server/features/shop/controllers/products/product_controller.dart';
import 'package:shopping_server/features/shop/controllers/products/product_variation_controller.dart';
import 'package:shopping_server/features/shop/models/products/product_model.dart';
import 'package:shopping_server/utils/constants/enums.dart';
import 'package:shopping_server/utils/popups/loader.dart';
import 'package:shopping_server/utils/storage/storage_utility.dart';

import '../../models/cart_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  RxInt noOfCartItem = 0.obs;
  RxInt productQuantityCartItem = 0.obs;
  RxDouble totalPrice = 0.0.obs;

  // Một danh sách để chứa các phần tử trong giỏ hàng
  RxList<CartModel> cartItems = <CartModel>[].obs;
  RxBool isLoading = false.obs;

  final variationController = ProductVariationController.instance;

  CartController() {
    loadCartItems();
  }

  // ---===--- Methods

  // Add product to cart
  void addToCart(ProductModel product) {
    /*
    * B1: Kiểm tra đã chọn số lượng sản phẩm cần mua chưa
    * B2: Kiểm tra đã chọn biến thể hay chưa
    * B3: Chuyển sản phầm được chọn từ ProductModel => CartModel
    * B4: Kiểm tra sản phẩm được chọn đã có trong giỏ hàng chưa
    * B5: Cập nhật giỏ hàng
    * B6: Thông báo kết quả
    * */

    // --- Quantity Check
    // Kiểm tra sản phẩm đã được thêm số lượng chưa
    if (productQuantityCartItem.value < 1) {
      CustomLoader.customToast(
          message: 'Please Select The Quantity You Want To Purchase!');
      return;
    }

    // --- Variation Selected Check
    // Kiểm tra biến thể sản phẩm
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      CustomLoader.customToast(
          message: 'Please Select The Variation You Want To Purchase!');
      return;
    }

    // --- Out of Stock Status Check
    // --- Check the product type (Variable/Single)

    // Kiểm tra xem sản phẩm còn hàng hay không?
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        CustomLoader.errorSnackBar(
            title: 'Variation Out of Stock',
            message:
                'Sorry, the variation you selected is run out of stock, please choose the others.');
        return;
      }
    } else {
      if (product.stock < 1) {
        CustomLoader.errorSnackBar(
            title: 'Product Out of Stock',
            message:
                'Sorry, the product you selected is run out of stock, please choose other products.');
        return;
      }
    }

    // Chuyển dữ liệu từ ProductModel lấy được ở UI => CartModel
    final selectedCartItem =
        convertToCartModel(product, productQuantityCartItem.value);

    // list[]
    // --- Kiểm tra xem sản phẩm có trong giỏ hàng hay chưa
    // --- Bằng cách so sánh id sản phẩm của data lấy từ UI với các id của phẩn tử trong danh sách
    // --- Trả về biến index
    int index = cartItems.indexWhere((item) =>
        item.productId == selectedCartItem.productId &&
        item.variationId == selectedCartItem.variationId);

    if (index >= 0) {
      // --- Nếu sản phẩm đã có trong giỏ hàng
      // --- Cập nhật số lượng của sản phẩm đó
      // ex: P01 so luong = 2 + 2 = 4
      cartItems[index].quantity += selectedCartItem.quantity;
    } else {
      // --- Nếu chưa thì thêm sản phẩm đã chọn vào danh sách
      cartItems.add(selectedCartItem);
      // list[] => list[P01]
      // list[P01] => list[P01, P02];
    }

    // Cập nhật lại giỏ hàng
    updateCart();

    CustomLoader.successSnackBar(
        title: 'Success!',
        message: 'The product has been successfully added to your cart.');
  }

  // Chuyển ProductModel sang CartModel
  CartModel convertToCartModel(ProductModel product, int quantity) {
    // --- Xóa dữ liệu trong model biến thể
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttribute();
    }

    // Kiểm tra biến thể sản phẩm để xác định giá tiền của sản phẩm
    final productVariation = variationController.selectedVariation.value;
    final isVariation = productVariation.id.isNotEmpty;
    final double price;

    // Nếu sản phẩm có biến thể
    if (isVariation) {
      // Nếu giá giảm của nó lớn hơn 0
      if (productVariation.salePrice > 0.0) {
        price = productVariation.salePrice;
      } else {
        price = productVariation.price;
      }
    }
    // Nếu sản phẩm không có biến thể và giá giảm của nó lớn hơn 0
    else if (product.salePrice > 0.0) {
      price = product.salePrice;
    } else {
      price = product.price;
    }

    // Trả về một CartModel với các dữ liệu lấy từ ProductModel và giá tiền vừa tính được
    return CartModel(
      // P01
      productId: product.id,
      // = 2
      quantity: quantity,
      price: price,
      variationId: productVariation.id,
      brandName: product.brand?.brandName,
      productName: product.title,
      image: isVariation ? productVariation.image : product.thumbnail,
      selectedVariation: isVariation ? productVariation.attributeValue : null,
    );
  }

  // Tăng số lượng của một sản phẩm cụ thể trong giỏ hàng hoặc thêm mới sản phẩm
  void increaseProductQuantity(CartModel item) {
    final index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      // Nếu đã có trong danh sách thì tăng số lượng của sản phẩm đó thêm 1
      cartItems[index].quantity += 1;
    } else {
      // Nếu chưa có thì thêm sản phẩm vào danh sách
      cartItems.add(item);
    }

    updateCart();
  }

  // Reduce one specific product quantity from cart
  // or remove from cart if its quantity already equals to 1

  // Giảm số lượng của một sản phẩm cụ thể trong giỏ hàng
  void reduceProductQuantity(CartModel item) {
    final index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      // --- If the quantity larger than 1, then reduce 1 element of quantity
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        // --- If the quantity is already 1, then remove it from the list
        cartItems.removeAt(index);
      }
    }

    updateCart();
  }

  void updateCart() {
    updateCartTotalItems();
    saveCartItems();
    cartItems.refresh();
    productQuantityCartItem.value = 0;
  }

  // Update total price and quantity of cartItems
  void updateCartTotalItems() {
    double calculatedTotalItemPrice = 0.0;
    int calculatedNoOfCartItem = 0;

    // --- Loop to calculate the total price and total number of item in the list
    for (var items in cartItems) {
      // P01 50$ 2 = 50*2 = 100
      calculatedTotalItemPrice += (items.price) * items.quantity.toDouble();
      // 0 + 2 = 2 + 1 = 3
      calculatedNoOfCartItem += items.quantity;
    }

    totalPrice.value = calculatedTotalItemPrice;
    noOfCartItem.value = calculatedNoOfCartItem;
  }

  // Update specific product stock to database
  void updateProductStock() {
    try {
      for (var index = 0; index < cartItems.length; index++) {
        final newStock = ProductController.instance.listProduct[index].stock - cartItems[index].quantity;
        ProductRepository.instance.updateProductStock(
            cartItems[index], newStock);
      }
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Lưu dữ liệu từ app đến bộ nhớ thiết bị
  void saveCartItems() {
    // --- Write the cartItems data to local device storage
    final cartItemString = cartItems.map((item) => item.toJson()).toList();
    LocalStorage.instance().saveData('cartItems', cartItemString);
  }

  // Tải dữ liệu từ bộ nhớ thiết bị lên app
  void loadCartItems() {
    isLoading.value = true;
    // --- Return the local device data to cartItems list
    final localCartItems =
        LocalStorage.instance().readData<List<dynamic>>('cartItems');

    if (localCartItems != null) {
      cartItems.assignAll(localCartItems
          .map((item) => CartModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotalItems();
    }

    isLoading.value = false;
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);

    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (item) =>
            item.productId == productId && item.variationId == variationId,
        orElse: () => CartModel.empty());

    return foundItem.quantity;
  }

  // Xóa toàn bộ phần tử trong giỏ hàng
  void clearCart() {
    productQuantityCartItem.value = 0;
    cartItems.clear();
    updateCart();
  }
}
