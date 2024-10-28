import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String image;
  bool active;
  String targetScreen;

  BannerModel( {
    required this.image,
    required this.active,
    required this.targetScreen,
  });

  Map<String, dynamic> toJson() {
    return {
      "Image": image,
      "TargetScreen": targetScreen,
      "Active": active,
    };
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return BannerModel(
        image: data["Image"] ?? '',
        active: data["Active"] ?? false,
        targetScreen: data["TargetScreen"] ?? '',
      );
    } else {
      return empty();
    }
  }

  static BannerModel empty() {
    return BannerModel(
      image: '',
      active: false,
      targetScreen: '',
    );
  }
}
