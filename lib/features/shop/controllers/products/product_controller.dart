import 'package:get/get.dart';
import 'package:shopping_server/data/repositories/brand_repository.dart';
import 'package:shopping_server/data/repositories/product_repository.dart';
import 'package:shopping_server/features/shop/models/brand_model.dart';
import 'package:shopping_server/utils/popups/loader.dart';

import '../../models/products/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  // Variables
  final _repo = Get.put(ProductRepository());
  final brandRepo = Get.put(BrandRepository());
  RxBool isLoading = false.obs;
  RxList<ProductModel> listProduct = <ProductModel>[].obs;
  RxList<ProductModel> featureProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    _fetchFeatureData();
  }

  Future<void> _fetchFeatureData() async {
    try {
      isLoading.value = true;

      final list = await _repo.getFeatureItem();
      final allList = await _repo.getAllFeatureItem();

      featureProducts.assignAll(list);
      listProduct.assignAll(allList);
    } catch (e) {
      isLoading.value = false;
      CustomLoader.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeatureData() async {
    try {
      final list = await _repo.getAllFeatureItem();

      return list;
    } catch (e) {
      CustomLoader.errorSnackBar(title: "Oh Snap!", message: e.toString());
      return [];
    }
  }

  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    if (product.productType == 'ProductType.single') {
      return product.salePrice > 0 ? '\$${product.salePrice}' : '\$${product.price}';
    } else {
      for (var item in product.productVariation!) {
        final actualPrice = item.salePrice > 0 ? item.salePrice : item.price;
        if (actualPrice < smallestPrice) {
          smallestPrice = actualPrice;
        }
        if (actualPrice > largestPrice) {
          largestPrice = actualPrice;
        }
      }
      if (smallestPrice.isEqual(largestPrice)) {
        return '\$$largestPrice';
      } else {
        return '\$$smallestPrice - \$$largestPrice';
      }
    }
  }

  String? getSaleDiscount(double? salePrice, double originalPrice) {
    if (salePrice == null || salePrice <= 0) return null;
    if (originalPrice <= 0) return null;
    final percentPrice = ((originalPrice - salePrice) / originalPrice) * 100.0;
    return percentPrice.toStringAsFixed(0);
  }

  String getStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  Future<BrandModel> getBrandByProduct(String productBrandId) async{
    try {
      final brands = await brandRepo.getBrandByProduct(productBrandId);

      return brands;
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return BrandModel.empty();
    }
  }
}