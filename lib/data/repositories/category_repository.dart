import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopping_server/features/shop/models/category_model.dart';
import 'package:shopping_server/utils/exceptions/firebase_exceptions.dart';
import 'package:shopping_server/utils/exceptions/platform_exceptions.dart';
import 'package:shopping_server/utils/services/local_firebase_storage_service.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // --- Get all categories
  Future<List<CategoryModel>> getAllCategory() async {
    try {
      // Get snapshot in 'Categories' collection of Cloud Firestore
      final snapshot = await _db.collection("Categories").get();

      // Convert snapshot to Category Model and return it
      final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw LocalFirebaseExceptions(e.code).toString();
    } on PlatformException catch(e) {
      throw LocalPlatformExceptions(e.code).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  // --- Get sub categories
  Future<List<CategoryModel>> getSubCategory(String categoryId) async {
    try {
      // Get snapshot in 'Categories' collection of Cloud Firestore
      final snapshot = await _db.collection("Categories")
          .where("ParentId", isEqualTo: categoryId).get();

      // Convert snapshot to Category Model and return it
      final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw LocalFirebaseExceptions(e.code).toString();
    } on PlatformException catch(e) {
      throw LocalPlatformExceptions(e.code).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  // --- Upload categories to the Cloud Firestore
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      // Create storage
      final storage = Get.put(LocalFirebaseStorageService());

      // Loop through each category
      for (var item in categories) {
        // Get ImageData link from local assets
        final file = await storage.getImageDataFromAssets(item.image);

        // Upload image and get its URL
        final url = await storage.uploadImageData('Categories', item.name, file);

        // Assign image url to item.image attribute
        item.image = url;

        // Store item to Firestore
        await _db.collection('Categories').doc(item.id).set(item.toJson());
      }
    } on FirebaseException catch (e) {
      throw LocalFirebaseExceptions(e.code).toString();
    } on PlatformException catch(e) {
      throw LocalPlatformExceptions(e.code).toString();
    } catch (e) {
      throw e.toString();
    }
  }
}