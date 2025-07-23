class ProductVariationModel {
  String? id;
  String? sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku,
    this.image = '',
    this.description,
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  ProductVariationModel copyWith({
    String? id,
    String? sku,
    String? image,
    String? description,
    double? price,
    double? salePrice,
    int? stock,
    Map<String, String>? attributeValues,
  }) {
    return ProductVariationModel(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      stock: stock ?? this.stock,
      attributeValues: attributeValues ?? this.attributeValues,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'sku': sku,
    'image': image,
    'description': description,
    'price': price,
    'salePrice': salePrice,
    'stock': stock,
    'attributeValues': attributeValues,
  };

  factory ProductVariationModel.fromJson(Map<String, dynamic> json) =>
      ProductVariationModel(
        id: json['id'] as String?,
        sku: json['sku'] as String?,
        image: json['image'] as String,
        description: json['description'] as String?,
        price: (json['price'] as num).toDouble(),
        salePrice: (json['salePrice'] as num).toDouble(),
        stock: json['stock'] as int,
        attributeValues: Map<String, String>.from(json['attributeValues']),
      );
}
