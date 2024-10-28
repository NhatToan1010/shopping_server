import 'package:get/get.dart';
import 'package:shopping_server/features/shop/controllers/image_slider_controller.dart';

import '../../models/products/product_model.dart';
import '../../models/products/product_variation_model.dart';

class ProductVariationController extends GetxController {
  static ProductVariationController get instance => Get.find();

  // Variables
  RxMap selectedAttribute = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  // --- Select attributes and variations
  void onAttributeSelected(
      ProductModel product, attributeName, attributeValue) {
    // When an attribute is selected, we will first add it to selectedAttribute
    final selectedAttribute = Map<String, dynamic>.from(this.selectedAttribute);
    selectedAttribute[attributeName] = attributeValue;
    this.selectedAttribute[attributeName] = attributeValue;

    final selectedVariation = product.productVariation!.firstWhere(
      (variation) => _isSameAttributeValues(variation.attributeValue, selectedAttribute),
      orElse: () => ProductVariationModel.empty(),
    );

    // Show the selected variation as a main image
    if (selectedVariation.image.isNotEmpty) {
      ImageSliderController.instance.currentImage.value =
          selectedVariation.image;
    }

    this.selectedVariation.value = selectedVariation;

    getProductVariationStockStatus();
  }

  // --- Check if selected attribute matches with variation attribute
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    // If number of attribute from selectedAttributes is not equal as variationAttribute,
    // then return false
    if (variationAttributes.length != selectedAttributes.length) return false;

    // If any from the attribute is different, then return false. ex: [Green, L] x [Green, S]
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  // --- Check product attribute availability and stock in variation
  Set<String?> getAttributeAvailabilityInVariation(List<ProductVariationModel> variations, attributeName) {
    // Pass the variation and check which attribute is available and stock is not 0
    final selectedAvailableVariationAttribute = variations
        .where((variation) =>
            // Check empty/out of stock value
            variation.attributeValue[attributeName] != null &&
            variation.attributeValue[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        // Fetch all not-empty attribute of variation
        .map((item) => item.attributeValue[attributeName])
        .toSet();

    return selectedAvailableVariationAttribute;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
        ? selectedVariation.value.salePrice
        : selectedVariation.value.price)
        .toString();
  }

  // --- Check product variation stock status
  String getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
    return variationStockStatus.value;
  }

  // --- Reset selected attribute and switching variation
  void resetSelectedAttribute() {
    selectedAttribute.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
