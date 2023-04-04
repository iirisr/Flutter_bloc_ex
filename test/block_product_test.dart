
import 'package:flutter_test/flutter_test.dart';
import 'package:products_ex/bloc/bloc_product_state.dart';
import 'package:products_ex/bloc/product_bloc.dart';
import 'package:products_ex/model/category.dart';
import 'package:products_ex/repository/products_local.dart';
import 'package:products_ex/repository/products_repository.dart';


void main() {
  late ProductBloc productBloc;
  late ProductsRepository productsRepository;
  late List<Category> categories;
  int productId = 1;

  setUp(() {
    ProductsLocal productLocal = ProductsLocal();
    productsRepository = ProductsRepository(productLocal);
    productBloc = ProductBloc(productsRepository: productsRepository);
    productBloc.loadProducts();
    categories = productsRepository.getCategories();
  });

  test('After initialization bloc state is correct', () async {
    productBloc = ProductBloc(productsRepository: productsRepository);
    expect(ProductsStateEmpty(), productBloc.state);
  });


  test('After loading products state should be emited', () async* {
    final expectedResponseForLoad = [
      TypeMatcher<ProductsStateLoading>(),
      TypeMatcher<ProductsStateSuccess>(),
    ];
    expect(productBloc.state, emitsInOrder(expectedResponseForLoad));
    productBloc.loadProducts();
  });

  test('After removing a product the value should be', () async* {
    final expectedResponseForRemoveItem = [
      TypeMatcher<ProductsStateLoading>(),
      TypeMatcher<ProductsStateSuccess>(),
    ];
    expect(productBloc.state, emitsInOrder(expectedResponseForRemoveItem));
    productBloc.removeItem(productId);
  });
}
