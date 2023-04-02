import 'package:products_ex/model/product.dart';

abstract class ProductsSource {
  Future<List<Product>> getProducts() async {
    // TODO: implement getProducts
    throw UnimplementedError();
  }
}