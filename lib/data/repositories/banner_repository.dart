import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../features/shop/models/banner_model.dart';
import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';
import '../../utils/services/local_firebase_storage_service.dart';

class BannerRepository extends GetxController {

  static BannerRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Get all order related to current user
  Future<List<BannerModel>> getAllBanner() async {
    try {
      // Get snapshot in 'Banners' collection of Cloud Firestore
      final snapshot = await _db.collection("Banners").where("Active", isEqualTo: true).get();

      // Convert snapshot to Banner Model and return them
      final list = snapshot.docs.map((document) => BannerModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw LocalFirebaseExceptions(e.code).toString();
    } on PlatformException catch(e) {
      throw LocalPlatformExceptions(e.code).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  // Upload all banner to Cloud Firestore
  Future<void> uploadDummyData(List<BannerModel> banners) async {
    try {
      // Create storage
      final storage = Get.put(LocalFirebaseStorageService());

      // Loop through each category
      for (var item in banners) {
        // Get ImageData link from local assets
        final file = await storage.getImageDataFromAssets(item.image);

        // Upload image to Firebase Storage and get its URL
        final url = await storage.uploadImageData('Banners', item.targetScreen, file);

        // Assign image url to item.image attribute
        item.image = url;

        // Store item to Cloud Firestore
        await _db.collection('Banners').doc().set(item.toJson());
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