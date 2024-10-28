import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  bool isFeature;
  String parentId;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeature,
    this.parentId = '',
  });

  // Convert Model into Json to store data to Firestore
  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Image": image,
      "IsFeature": isFeature,
      "ParentId": parentId,
    };
  }

  // Map Json oriented document snapshot from Firestore to Category Model
  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModel(
        id: document.id,
        name: data["Name"] ?? '',
        image: data["Image"] ?? '',
        isFeature: data["IsFeature"] ?? false,
        parentId: data["ParentId"] ?? '',
      );
    } else {
      return empty();
    }
  }

  // Get empty Category Model
  static CategoryModel empty() {
    return CategoryModel(
      id: '',
      name: '',
      image: '',
      isFeature: false,
      parentId: '',
    );
  }
}
