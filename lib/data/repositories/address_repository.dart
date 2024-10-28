import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_server/data/repositories/authentication_repository.dart';
import 'package:shopping_server/features/personalization/models/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> getAllUserAddress() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw '"Get" Address Repository Error: Unable to find current user!';
      }

      final result = await _db
          .collection("User")
          .doc(userId)
          .collection("Addresses")
          .get();
      return result.docs
          .map((item) => AddressModel.fromSnapshot(item))
          .toList();
    } catch (e) {
      throw '"Get" Address Repository Error: ${e.toString()}';
    }
  }

  Future<void> updateSelectedAddress(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection("User")
          .doc(userId)
          .collection("Addresses")
          .doc(addressId)
          .update({"SelectedAddress": selected});
    } catch (e) {
      throw '"Update" Address Repository Error: ${e.toString()}';
    }
  }

  Future<String> addNewAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await _db
          .collection("User")
          .doc(userId)
          .collection("Addresses").add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw '"Add New" Address Repository Error: ${e.toString()}';
    }
  }
}
