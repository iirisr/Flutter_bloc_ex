
import 'package:flutter_test/flutter_test.dart';
import 'package:products_ex/bloc/product_bloc.dart';
import 'package:products_ex/model/category.dart';
import 'package:products_ex/model/product.dart';
import 'package:products_ex/repository/products_local.dart';
import 'package:products_ex/repository/products_repository.dart';

void main() {
  late ProductBloc productBloc;
  late ProductsRepository productsRepository;

  setUp(() {
    ProductsLocal productLocal = ProductsLocal();
    productsRepository = ProductsRepository(productLocal);
    productBloc = ProductBloc(productsRepository: productsRepository);
    productBloc.loadProducts();
  });

  test('After removing a product the value should be', () async {
    int sumOfItemsInCategoryBeforeRemove = -1;
    int sumOfItemsInStockBeforeRemove = -1;
    int sumOfItemsInCategoryAfterRemove = -1;
    int sumOfItemsInStockAfterRemove = -1;

    productBloc.loadProducts();
    Product product = productsRepository.getProducts()[0];
    List<Category> categories = productsRepository.getCategories();
    for (int i=0; i<categories.length; i++) {
      if (categories[i].name == product.category) {
        sumOfItemsInStockBeforeRemove = categories[i].sumOfItemsInInventory;
        sumOfItemsInCategoryBeforeRemove = categories[i].sumOfItemsInCategory;
      }
    }

    productBloc.removeItem(product.id);
    bool productExists = productsRepository.getProducts().contains(product.id);
    expect(productExists, false);

    categories = productsRepository.getCategories();
    for (int i=0; i<categories.length; i++) {
      if (categories[i].name == product.category) {
        sumOfItemsInStockAfterRemove = categories[i].sumOfItemsInInventory;
        sumOfItemsInCategoryAfterRemove = categories[i].sumOfItemsInCategory;
      }
    }

    expect(sumOfItemsInCategoryBeforeRemove != -1 &&
        sumOfItemsInCategoryBeforeRemove != -1 &&
        sumOfItemsInCategoryBeforeRemove != -1 &&
        sumOfItemsInCategoryBeforeRemove != -1,
        true);

    expect(sumOfItemsInStockAfterRemove, sumOfItemsInStockBeforeRemove-product.stock);
    expect(sumOfItemsInCategoryAfterRemove, sumOfItemsInCategoryBeforeRemove-1);

  });
}