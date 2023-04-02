import 'package:equatable/equatable.dart';

import '../model/product.dart';

abstract class ProductsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductItemsLoadedEvent extends ProductsEvent {
  final List<Product> productsList;

  ProductItemsLoadedEvent({required this.productsList});

  @override
  List<Object> get props => [productsList];

  @override
  String toString() => "ProductItemsUpdatedEvent { productsList: $productsList }";
}

class ProductItemRemovedEvent extends ProductsEvent {
  final int productId;

  ProductItemRemovedEvent({required this.productId});

  @override
  List<Object> get props => [productId];

  @override
  String toString() => "ProductItemRemovedEvent { productId: $productId }";
}