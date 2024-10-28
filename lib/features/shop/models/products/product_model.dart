import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_server/features/shop/models/brand_model.dart';
import 'package:shopping_server/features/shop/models/products/product_attribute_model.dart';
import 'package:shopping_server/features/shop/models/products/product_variation_model.dart';

class ProductModel {
  String id;
  String title;
  String thumbnail;
  String productType;
  String? categoryId;
  String? description;
  String? sku;
  List<String>? images;
  int stock;
  double price;
  double salePrice;
  bool isFeature;
  DateTime? date;
  BrandModel? brand;
  List<ProductAttributeModel>? productAttribute;
  List<ProductVariationModel>? productVariation;

  ProductModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.productType,
    required this.stock,
    required this.price,
    this.salePrice = 0.0,
    this.categoryId,
    this.description,
    this.sku,
    this.images,
    this.isFeature = false,
    this.date,
    this.brand,
    this.productAttribute,
    this.productVariation,
  });

  static ProductModel empty() {
    return ProductModel(
      id: '',
      title: '',
      thumbnail: '',
      productType: '',
      stock: 0,
      price: 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "Title": title,
      "Thumbnail": thumbnail,
      "ProductType": productType,
      "Stock": stock,
      "Description": description,
      "Price": price,
      "SalePrice": salePrice,
      "CategoryId": categoryId,
      "SKU": sku,
      "Images": images ?? [],
      "IsFeature": isFeature,
      "Brand": brand!.toJson(),
      "ProductAttribute": productAttribute != null
          ? productAttribute!.map((element) => element.toJson()).toList()
          : [],
      "ProductVariation": productVariation != null
          ? productVariation!.map((element) => element.toJson()).toList()
          : [],
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    if (data.isEmpty) return empty();
    return ProductModel(
      id: data["Id"] ?? '',
      title: data["Title"] ?? '',
      thumbnail: data["Thumbnail"] ?? '',
      productType: data["ProductType"] ?? '',
      sku: data["SKU"] ?? '',
      description: data["Description"] ?? '',
      categoryId: data["CategoryId"] ?? '',
      isFeature: data["IsFeature"] ?? false,
      stock: data["Stock"] ?? 0,
      price: double.parse((data["Price"] ?? 0.0).toString()),
      salePrice: double.parse((data["SalePrice"] ?? 0.0).toString()),
      images: data["Images"] != null ? List<String>.from(data["Images"]) : [],
      brand: BrandModel.fromJson(data["Brand"]),
      productAttribute: (data["ProductAttribute"] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariation: (data["ProductVariation"] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }

  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return ProductModel(
      id: data["Id"] ?? '',
      title: data["Title"] ?? '',
      thumbnail: data["Thumbnail"] ?? '',
      productType: data["ProductType"] ?? '',
      sku: data["SKU"] ?? '',
      description: data["Description"] ?? '',
      categoryId: data["CategoryId"] ?? '',
      isFeature: data["IsFeature"] ?? false,
      stock: data["Stock"] ?? 0,
      price: double.parse((data["Price"] ?? 0.0).toString()),
      salePrice: double.parse((data["SalePrice"] ?? 0.0).toString()),
      images: data["Images"] != null ? List<String>.from(data["Images"]) : [],
      brand: BrandModel.fromJson(data["Brand"]),
      productAttribute: (data["ProductAttribute"] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariation: (data["ProductVariation"] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }
}
