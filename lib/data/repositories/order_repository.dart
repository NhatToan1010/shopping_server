import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_server/data/repositories/authentication_repository.dart';

import '../../features/shop/models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();
  
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  // --- Get All User Order
  Future<List<OrderModel>> fetchAllUserOrder() async {
    try {
      // --- Find Current User Id
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Oder Repository Error: Unable to find user!';
      }

      // --- If User Id is not null then go to 'Orders' collection of current User
      // --- Get all data from 'Orders' collection
      final result = await _db.collection("User").doc(userId).collection("Orders").get();

      // --- Converting received data from Json into OrderModel and return List of Order
      return result.docs.map((item) => OrderModel.fromSnapShot(item)).toList();
    } catch (e) {
      throw 'Oder Repository Error: ${e.toString()}';
    }
  }

  // --- Add New Order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try{
      await _db.collection("User").doc(userId).collection("Orders").doc(order.id).set(order.toJson());
    } catch (e) {
      throw 'Oder Repository Error: ${e.toString()}';
    }
  }
}