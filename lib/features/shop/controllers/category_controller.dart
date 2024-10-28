import 'package:get/get.dart';
import 'package:shopping_server/data/repositories/category_repository.dart';
import 'package:shopping_server/data/repositories/product_repository.dart';
import 'package:shopping_server/features/shop/models/category_model.dart';
import 'package:shopping_server/features/shop/models/products/product_model.dart';
import 'package:shopping_server/utils/popups/loader.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  // Variables
  final _categoryRepo = Get.put(CategoryRepository());
  RxBool isLoading = false.obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    _fetchAllCategories();
  }

  // --- Load categories data
  Future<void> _fetchAllCategories() async {
    try {
      // Start loading
      isLoading.value = true;

      // Fetch categories from data source
      final list = await _categoryRepo.getAllCategory();

      // Update allCategories list
      allCategories.assignAll(list);

      // Filter feature categories just take category that is feature and does not have parent id
      featuredCategories.assignAll(
          allCategories
              .where((category) => category.isFeature && category.parentId.isEmpty)
              .take(8).toList()
      );
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Stop loading
      isLoading.value = false;
    }
  }

  // --- Load selected categories data
  Future<List<CategoryModel>> getSubCategory(String categoryId) async {
    try {
      // Fetch categories from data source
      final subCategory = await _categoryRepo.getSubCategory(categoryId);

      return subCategory;
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  // --- Get category or sub-category products
  Future<List<ProductModel>> getCategoryProduct({required String categoryId, int limit = 4}) async {
    try {
      // Fetch categories from data source
      final productList = await ProductRepository.instance.getProductsForCategory(categoryId: categoryId, limit: limit);

      return productList;
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}