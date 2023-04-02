import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:products_ex/bloc/blocProductState.dart';
import 'package:products_ex/repository/products_repository.dart';

class ProductItemRemovedBloc extends Cubit<ProductsState> {
  final ProductsRepository productsRepository;

  ProductItemRemovedBloc({required this.productsRepository}) : super(ProductsStateItemRemoved(productsRepository.getCategories()));

  Future<void> removeItem(int productId) async {
    emit(ProductsStateLoading());
    bool success = productsRepository.removeItem(productId);
    if (success) {
      emit(ProductsStateSuccess(productsRepository.getCategories()));
    }
    else {
      emit(ProductsStateError('Product id $productId not found!!'));
    }
  }
}
