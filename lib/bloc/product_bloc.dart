import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/category.dart';
import '../repository/products_repository.dart';
import 'bloc_product_state.dart';


class ProductBloc extends Cubit<ProductsState> {
  final ProductsRepository productsRepository;

  ProductBloc({required this.productsRepository}) : super(ProductsStateEmpty());

  Future<void> loadProducts() async {
    emit(ProductsStateLoading());
    List<Category> list = await productsRepository.loadCategories();
    emit(ProductsStateSuccess(list));
  }

  Future<void> removeItem(int productId) async {
    emit(ProductsStateLoading());
    bool success = productsRepository.removeItem(productId);
    print('Item removed. success=$success');
    if (success) {
      emit(ProductsStateSuccess(productsRepository.getCategories()));
    }
    else {
      emit(ProductsStateError('Product id $productId not found!!'));
    }
  }
}
