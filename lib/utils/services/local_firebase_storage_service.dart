import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LocalFirebaseStorageService extends GetxController {
  static LocalFirebaseStorageService get instance => Get.find();

  // Variables
  final _firebaseStorage = FirebaseStorage.instance;

  // --- Upload local assets from IDE
  // Return Uint8List containing image data
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      throw 'Handle Image Data Error: $e';
    }
  }

  // --- Upload image using ImageData from Cloud Firestore Storage
  // Return the download URL of the uploaded image
  Future<String> uploadImageData(String path, String name, Uint8List image) async {
    try {
      // Create a path in FireStorage and put image data
      final ref = _firebaseStorage.ref(path).child(name);
      await ref.putData(image);

      // Return the download URL of image
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'Firebase Error: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Error: ${e.message}';
      } else {
        throw 'Something went wrong: ${e.toString()}';
      }
    }
  }

  // --- Upload image to Cloud Firebase Storage
  // Return the download URL of the uploaded image
  Future<String> uploadImageFile(String path, XFile image) async {
    try {
      // Create a path in FireStorage and put image file
      final ref = _firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));

      // Return the download URL of image
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'Firebase Error: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Error: ${e.message}';
      } else {
        throw 'Something went wrong: ${e.toString()}';
      }
    }
  }
}