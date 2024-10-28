import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_server/data/repositories/product_repository.dart';
import 'package:shopping_server/features/shop/models/products/product_model.dart';
import 'package:shopping_server/utils/popups/loader.dart';

class AllProductController extends GetxController {
  static AllProductController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  // --- Fetch product list by query
  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) return [];

      final products = await repository.getProductsByQuery(query);

      return products;
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  // --- Sort product by options
  void sortProduct(String sortOption) {
    selectedSortOption.value = sortOption;
    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Highest Price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lowest Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Newest':
        products.sort((a, b) => a.date!.compareTo(b.date!));
      case 'Sale':
        products.sort((a, b) {
          if (b.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;

      // --- Sort by Name as default option
      default: products.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> products) {
    // --- Assign current products to products list
    this.products.assignAll(products);
    sortProduct('Name');
  }
}