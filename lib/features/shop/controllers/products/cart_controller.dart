import 'package:get/get.dart';
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
  RxList<CartModel> cartItems = <CartModel>[].obs;
  RxBool isLoading = false.obs;

  final variationController = ProductVariationController.instance;

  CartController() {
    loadCartItems();
  }

  // ---===--- Methods

  // Add product to cart
  void addToCart(ProductModel product) {
    // --- Quantity Check
    if (productQuantityCartItem.value < 1) {
      CustomLoader.customToast(
          message: 'Please Select The Quantity You Want To Purchase!');
      return;
    }

    // --- Variation Selected Check
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      CustomLoader.customToast(
          message: 'Please Select The Variation You Want To Purchase!');
      return;
    }

    // --- Out of Stock Status Check
    // --- Check the product type (Variable/Single)
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

    final selectedCartItem =
        convertToCartModel(product, productQuantityCartItem.value);

    // --- Check if product has already added to cart
    // --- If found productId and variationId of the product in cartItems list
    // --- Return the index of it
    int index = cartItems.indexWhere((item) =>
        item.productId == selectedCartItem.productId &&
        item.variationId == selectedCartItem.variationId);

    if (index >= 0) {
      // --- If product already in the cart item list
      // --- Update the quantity
      cartItems[index].quantity += selectedCartItem.quantity;
    } else {
      // --- Or else, add product to the list
      cartItems.add(selectedCartItem);
    }

    updateCart();

    CustomLoader.successSnackBar(
        title: 'Success!',
        message: 'The product has been successfully added to your cart.');
  }

  // Convert ProductModel to CartModel
  CartModel convertToCartModel(ProductModel product, int quantity) {
    // --- Clear the product variation in case of the product type is single
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttribute();
    }

    final productVariation = variationController.selectedVariation.value;
    final isVariation = productVariation.id.isNotEmpty;
    final price = isVariation
        ? productVariation.salePrice > 0.0
            ? productVariation.salePrice
            : productVariation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;

    // --- Create a new item for cartItems also manage its quantity, and other attributes.
    return CartModel(
      productId: product.id,
      quantity: quantity,
      price: price,
      variationId: productVariation.id,
      brandName: product.brand?.brandName,
      productName: product.title,
      image: isVariation ? productVariation.image : product.thumbnail,
      selectedVariation: isVariation ? productVariation.attributeValue : null,
    );
  }

  // Increase one specific product quantity from cart or add it to cart if it new
  void increaseProductQuantity(CartModel item) {
    final index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }

    updateCart();
  }

  // Reduce one specific product quantity from cart
  // or remove from cart if its quantity already equals to 1
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
      calculatedTotalItemPrice += (items.price) * items.quantity.toDouble();
      calculatedNoOfCartItem += items.quantity;
    }

    totalPrice.value = calculatedTotalItemPrice;
    noOfCartItem.value = calculatedNoOfCartItem;
  }

  void saveCartItems() {
    // --- Write the cartItems data to local device storage
    final cartItemString = cartItems.map((item) => item.toJson()).toList();
    LocalStorage.instance().saveData('cartItems', cartItemString);
  }

  void loadCartItems() {
    isLoading.value = true;
    // --- Return the local device data to cartItems list
    final localCartItems = LocalStorage.instance().readData<List<dynamic>>('cartItems');

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

  void clearCart() {
    productQuantityCartItem.value = 0;
    cartItems.clear();
    updateCart();
  }
}
