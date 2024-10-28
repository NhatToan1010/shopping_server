class ProductVariationModel {
  final String id;
  String description;
  String? sku;
  String image;
  int stock;
  double price;
  double salePrice;
  Map<String, String> attributeValue;

  ProductVariationModel({
    required this.id,
    required this.attributeValue,
    this.image = '',
    this.stock = 0,
    this.price = 0.0,
    this.salePrice = 0.0,
    this.description = '',
    this.sku = '',
  });

  static ProductVariationModel empty() {
    return ProductVariationModel(id: '', attributeValue: {});
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "Description": description,
      "SKU": sku,
      "Image": image,
      "Stock": stock,
      "Price": price,
      "SalePrice": salePrice,
      "AttributeValue": attributeValue
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isNotEmpty) {
      return ProductVariationModel(
        id: data["Id"] ?? '',
        attributeValue: Map<String, String>.from(data["AttributeValue"]),
        description: data["Description"] ?? '',
        sku: data["SKU"] ?? '',
        salePrice: double.parse((data["SalePrice"] ?? 0.0).toString()),
        price: double.parse((data["Price"] ?? 0.0).toString()) ,
        stock: data["Stock"] ?? 0,
        image: data["Image"],
      );
    } else {
      return empty();
    }
  }
}
