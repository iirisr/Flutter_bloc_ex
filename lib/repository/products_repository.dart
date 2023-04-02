import 'package:products_ex/model/product.dart';
import 'package:products_ex/model/category.dart';
import 'package:products_ex/repository/products_source.dart';


class ProductsRepository {
  final ProductsSource productsSource;

  late List<Product> products = [];
  late Map<String,Category> categories = {};

  ProductsRepository(this.productsSource);

  List<Category> getCategories() {
    return categories.values.toList();
  }

  Future<List<Category>> loadCategories() async {
    products = await productsSource.getProducts();

    for (int i=0; i<products.length; i++) {
      if (categories[products[i].category] == null) {
        categories[products[i].category] = Category(
            name: products[i].category,
            sumOfItemsInCategory: 1,
            sumOfItemsInInventory: 1,
            thumbnail: products[i].images.length != 0 ? products[i].images[0] : null
        );
      }
      else {
        categories[products[i].category]!.setNumberOfItemsInCategory(
            categories[products[i].category]!.sumOfItemsInCategory+1);
        categories[products[i].category]!.setNumberOfItemsInInventory(
            categories[products[i].category]!.sumOfItemsInInventory+products[i].stock);
      }
    }

    return categories.values.toList();
  }

  bool removeItem(int productId) {
    Product? product;
    for (int i=0; i<products.length; i++) {
      if (products[i].id == productId) {
        product = products[i];
        products.removeAt(i);
        break;
      }
    }

    if (product == null) {
      return false;
    }

    categories[product.category]?.sumOfItemsInCategory -= 1;
    categories[product.category]?.sumOfItemsInInventory -= product.stock;
    if (categories[product.category]?.sumOfItemsInCategory == 0) {
      categories.remove(product.category);
    }

    return true;
  }
}