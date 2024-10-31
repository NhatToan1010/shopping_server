
class CartModel {
  String productId;
  String variationId;
  String productName;
  int quantity;
  num price;
  String? image;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartModel({
    required this.productId,
    this.variationId = '',
    this.productName = '',
    required this.quantity,
    this.price = 0.0,
    this.image,
    this.brandName,
    this.selectedVariation,
  });

  Map<String, dynamic> toJson() {
    return {
      "ProductId": productId,
      "VariationId": variationId,
      "ProductName": productName,
      "ProductImage": image,
      "BrandName": brandName,
      "Price": price,
      "Quantity": quantity,
      "SelectedVariation": selectedVariation,
    };
  }

  static empty() => CartModel(productId: '', quantity: 0);

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final data = json;

    return CartModel(
      productId: data["ProductId"] as String,
      quantity: data["Quantity"] as int,
      brandName: data["BrandName"] as String,
      image: data["ProductImage"] as String,
      productName: data["ProductName"] as String,
      variationId: data["VariationId"] as String,
      price: (data["Price"]) * 1.0,
      selectedVariation: data["SelectedVariation"] != null
          ? Map<String, String>.from(data["SelectedVariation"])
          : null,
    );
  }
}
