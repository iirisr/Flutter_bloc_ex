import 'dart:core';

import 'package:equatable/equatable.dart';

class Product extends Equatable{
  final int id;
  final String title;
  //final String description;
  final int price;
  final double discountPercentage;
  final double rating;
  final int stock;
  //final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  const Product({
    required this.id,
    required this.title,
    //required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    //required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  @override
  List<Object> get props => [id, title, price, discountPercentage, rating, stock, category, thumbnail, images];

}
