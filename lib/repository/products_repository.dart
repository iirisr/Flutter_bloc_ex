import 'package:products_ex/model/product.dart';
import 'package:products_ex/model/category.dart';
import 'package:products_ex/repository/products_source.dart';


class ProductsRepository {
  final ProductsSource _productsSource;

  late List<Product> _products = [];
  late Map<String,Category> _categories = {};

  ProductsRepository(this._productsSource);

  List<Category> getCategories() {
    return _categories.values.toList();
  }

  List<Product> getProducts() {
    return _products;
  }

  Future<List<Category>> loadCategories() async {
    _products = await _productsSource.getProducts();

    for (int i=0; i<_products.length; i++) {
      if (_categories[_products[i].category] == null) {
        _categories[_products[i].category] = Category(
            name: _products[i].category,
            sumOfItemsInCategory: 1,
            sumOfItemsInInventory: 1,
            thumbnail: _products[i].images.length != 0 ? _products[i].images[0] : null
        );
      }
      else {
        _categories[_products[i].category]!.setNumberOfItemsInCategory(
            _categories[_products[i].category]!.sumOfItemsInCategory+1);
        _categories[_products[i].category]!.setNumberOfItemsInInventory(
            _categories[_products[i].category]!.sumOfItemsInInventory+_products[i].stock);
      }
    }

    return _categories.values.toList();
  }

  List<Product> getProductsForCategory(String categoryName) {
    List<Product> list = [];
    for (int i=0; i<_products.length; i++) {
      if (_products[i].category == categoryName) {
        list.add(_products[i]);
      }
    }

    return list;
  }

  bool removeItem(int productId) {
    Product? product;
    for (int i=0; i<_products.length; i++) {
      if (_products[i].id == productId) {
        product = _products[i];
        _products.removeAt(i);
        break;
      }
    }

    if (product == null) {
      print("Can't delete item. Product not found");
      return false;
    }

    _categories[product.category]?.sumOfItemsInCategory -= 1;
    _categories[product.category]?.sumOfItemsInInventory -= product.stock;
    if (_categories[product.category]?.sumOfItemsInCategory == 0) {
      _categories.remove(product.category);
    }

    return true;
  }
}