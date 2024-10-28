import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_server/data/repositories/authentication_repository.dart';
import 'package:shopping_server/features/authentication/models/user_model.dart';

import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save user data into Cloud Firestore
  Future<void> saveUserRecord(UserModel user) async{
    try {
      _db.collection("User").doc(user.id).set(user.toJSON());
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // Fetch user details from collection base on user UID
  Future<UserModel> fetchUserDetail() async {
    try {
      // Get data from document by current user UID
      final documentSnapshot = await _db.collection("User")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        // Transform the JSON data to UserModel
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // Update all user data in Cloud Firestore
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db.collection("User")
          .doc(updatedUser.id)
          .update(updatedUser.toJSON());
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // Update any field specific user collections
  Future<void> updateSpecificField(Map<String, dynamic> json) async {
    try {
      await _db.collection("User")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // Remove user details from Cloud Firestore
  Future<void> removeUser(String userId) async {
    try {
      await _db.collection("User").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // Upload Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      // Create reference for Firebase Storage (ex:Users/Images/Profile/)
      final ref = FirebaseStorage.instance.ref(path).child(image.name);

      // Upload image file to Firebase Storage
      await ref.putFile(File(image.path));

      // Return an image url to local device
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }
}