import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String brandName;
  String image;
  bool? isFeature;
  int? itemCount;

  BrandModel({
    required this.id,
    required this.brandName,
    required this.image,
    this.isFeature,
    this.itemCount = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "BrandName": brandName,
      "Image": image,
      "IsFeature": isFeature,
      "ItemCount": itemCount
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isNotEmpty) {
      return BrandModel(
        id: data["Id"] ?? '',
        brandName: data["BrandName"] ?? '',
        image: data["Image"] ?? '',
        isFeature: data["IsFeature"] ?? false,
        itemCount: int.parse((data["ItemCount"] ?? 0).toString()),
      );
    } else {
      return empty();
    }
  }

  static BrandModel empty() {
    return BrandModel(id: '', brandName: '', image: '');
  }

  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data()!.isNotEmpty) {
      final data = document.data()!;

      return BrandModel(
        id: document.id,
        brandName: data["BrandName"] ?? '',
        image: data["Image"] ?? '',
        isFeature: data["IsFeature"] ?? false,
        itemCount: data["ItemCount"] ?? 0,
      );
    } else {
      return empty();
    }
  }
}
