import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../features/shop/models/brand_model.dart';
import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';
import '../../utils/services/local_firebase_storage_service.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // --- Get all brand
  Future<List<BrandModel>> getAllItem() async {
    try {
      // Get snapshot in 'Products' collection of Cloud Firestore
      final snapshot = await _db.collection("Brands").get();

      // Convert snapshot to Product Model and return it
      final list = snapshot.docs
          .map((document) => BrandModel.fromSnapshot(document))
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

  Future<BrandModel> getBrandByProduct(String productBrandId) async {
    try {
      final brand = await _db
          .collection("Brands").doc(productBrandId)
          .get();

      return BrandModel.fromSnapshot(brand);
    } catch (e) {
      throw 'Brand Repository Error: ${e.toString()}';
    }
  }

  // Upload all brand to Cloud Firestore
  Future<void> uploadDummyData(List<BrandModel> banners) async {
    try {
      // Create storage
      final storage = Get.put(LocalFirebaseStorageService());

      // Loop through each category
      for (var item in banners) {
        // Get ImageData link from local assets
        final file = await storage.getImageDataFromAssets(item.image);

        // Upload image to Firebase Storage and get its URL
        final url =
            await storage.uploadImageData('Brands', item.brandName, file);

        // Assign image url to item.image attribute
        item.image = url;

        // Store item to Cloud Firestore
        await _db.collection('Brands').doc(item.id).set(item.toJson());
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
