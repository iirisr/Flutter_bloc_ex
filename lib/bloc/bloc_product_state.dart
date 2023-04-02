import 'package:equatable/equatable.dart';

import '../model/category.dart';

abstract class ProductsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductsStateLoading extends ProductsState {
  @override
  String toString() => 'ProductsStateLoading';
}

class ProductsStateEmpty extends ProductsState {
  @override
  String toString() => 'ProductsStateEmpty';
}

class ProductsStateError extends ProductsState {
  final String error;

  ProductsStateError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ProductsStateError { error: $error }';
}

class ProductsStateSuccess extends ProductsState {
  final List<Category> categories;

  ProductsStateSuccess(this.categories);

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'ProductsStateSuccess { products: ${categories.length} }';
}

