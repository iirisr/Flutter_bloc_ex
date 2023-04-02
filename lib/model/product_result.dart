import 'dart:core';


class ProductResult {
  final List<ProductResultItem> productResultsItems;

  const ProductResult({required this.productResultsItems});

  static ProductResult fromJson(Map<String, dynamic> json) {//(dynamic json) {
    print("ProductResult, json=$json");
    final items = (json['products'] as List<dynamic>)
        .map(
          (dynamic item) =>
              ProductResultItem.fromJson(item as Map<String, dynamic>),
        )
        .toList();
     return ProductResult(productResultsItems: items);
  }
}

class ProductResultItem {
  final int id;
  final String title;
  final String description;
  final int price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  const ProductResultItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  static ProductResultItem fromJson(Map<String, dynamic> json) {

    return ProductResultItem(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      discountPercentage: double.parse(json['discountPercentage'].toString()),
      rating: double.parse(json['rating'].toString()),
      stock: json['stock'] as int,
      brand: json['brand'] as String,
      category: json['category'] as String,
      thumbnail: json['thumbnail'] as String,
      images: json['images'].cast<String>()
    );
  }
}
