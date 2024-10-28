import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../features/shop/models/products/product_model.dart';
import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';
import '../../utils/services/local_firebase_storage_service.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> getFeatureItem() async {
    try {
      // Get snapshot in 'Products' collection of Cloud Firestore
      final snapshot = await _db
          .collection("Products")
          .where("IsFeature", isEqualTo: true)
          .limit(4)
          .get();

      // Convert snapshot to Product Model and return it
      final list = snapshot.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw LocalFirebaseExceptions(e.code).toString();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ProductModel>> getAllFeatureItem() async {
    try {
      // Get snapshot in 'Products' collection of Cloud Firestore
      final snapshot = await _db
          .collection("Products")
          .where("IsFeature", isEqualTo: true)
          .get();

      // Convert snapshot to Product Model and return it
      final list = snapshot.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw LocalFirebaseExceptions(e.code).toString();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ProductModel>> getAllProduct() async {
    try {
      // Get snapshot in 'Products' collection of Cloud Firestore
      final snapshot = await _db.collection("Products").get();

      // Convert snapshot to Product Model and return it
      final list = snapshot.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw LocalFirebaseExceptions(e.code).toString();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ProductModel>> getProductsByQuery(Query query) async {
    try {
      // Get snapshot in 'Products' collection of Cloud Firestore
      final querySnapshot = await query.get();

      // Convert snapshot to Product Model and return it
      final list = querySnapshot.docs
          .map((document) => ProductModel.fromQuerySnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw LocalFirebaseExceptions(e.code).toString();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  // --- Get product data by brand
  Future<List<ProductModel>> getProductsByBrand(
      {required String brandId, int limit = -1}) async {
    try {
      // Get snapshot in 'Products' collection (with specific brand) of Cloud Firestore
      final snapshot = limit == -1
          ? await _db
              .collection("Products")
              .where("Brand.Id", isEqualTo: brandId)
              .get()
          : await _db
              .collection("Products")
              .where("Brand.Id", isEqualTo: brandId)
              .limit(limit)
              .get();

      // Convert snapshot to Product Model and return it
      final list = snapshot.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw LocalFirebaseExceptions(e.code).toString();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  // --- Get product data by category
  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = -1}) async {
    try {
      // Get snapshot in 'Products' collection of Cloud Firestore
      final snapshot = limit == -1
          ? await _db
              .collection("ProductCategory")
              .where("CategoryId", isEqualTo: categoryId)
              .get()
          : await _db
              .collection("ProductCategory")
              .where("CategoryId", isEqualTo: categoryId)
              .limit(limit)
              .get();

      // Extract product from documents
      List<String> productIds = snapshot.docs
          .map((document) => document["ProductId"] as String)
          .toList();

      // Query to get all document with specific id
      final productQuery = await _db
          .collection("Products")
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      // Convert result into ProductModel
      List<ProductModel> products = productQuery.docs
          .map((item) => ProductModel.fromSnapshot(item))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw LocalFirebaseExceptions(e.code).toString();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      // Create storage
      final storage = Get.put(LocalFirebaseStorageService());

      // Loop through each item
      for (var item in products) {
        // Get ImageData link from local assets
        final thumbnail = await storage.getImageDataFromAssets(item.thumbnail);

        // Upload image and get its URL
        final url = await storage.uploadImageData(
            'Products/Images', item.thumbnail.toString(), thumbnail);

        // Assign image url to item.image attribute
        item.thumbnail = url;

        // Product list of images
        if (item.images != null && item.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in imagesUrl) {
            final assetImage = await storage.getImageDataFromAssets(image);

            final url = await storage.uploadImageData(
                'Products/Images', image, assetImage);

            imagesUrl.add(url);
          }
          item.images!.clear();
          item.images!.addAll(imagesUrl);
        }

        // Upload variation images
        if (item.productType == 'ProductType.variable') {
          List<String> variations = [];
          for (var value in variations) {
            final assetsImage = await storage.getImageDataFromAssets(value);

            final url = await storage.uploadImageData(
                'Products/Images', value, assetsImage);

            variations.add(url);
          }
        }

        // Store item to Firestore
        await _db.collection('Products').doc(item.id).set(item.toJson());
      }
    } on FirebaseException catch (e) {
      throw LocalFirebaseExceptions(e.code).toString();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).toString();
    } catch (e) {
      throw e.toString();
    }
  }
}
