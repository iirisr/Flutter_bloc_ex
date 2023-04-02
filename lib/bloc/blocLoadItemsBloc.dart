import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/category.dart';
import '../repository/products_repository.dart';
import 'blocProductState.dart';


class ProductLoadItemsBloc extends Cubit<ProductsState> {
  final ProductsRepository productsRepository;

  ProductLoadItemsBloc({required this.productsRepository}) : super(ProductsStateEmpty());

  Future<void> loadProducts() async {
    emit(ProductsStateLoading());
    List<Category> list = await productsRepository.loadCategories();
    emit(ProductsStateSuccess(list));
  }
}
