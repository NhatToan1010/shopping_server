class ProductAttributeModel {
  String? name;
  List<String>? values;

  ProductAttributeModel({this.name, this.values});

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Values": values,
    };
  }

  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isNotEmpty) {
      return ProductAttributeModel(
          name: data.containsKey("Name") ? data["Name"] : '',
          values: List<String>.from(data["Values"]),
      );
    } else {
      return ProductAttributeModel();
    }
  }
}