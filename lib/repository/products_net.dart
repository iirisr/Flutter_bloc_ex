import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:products_ex/repository/products_source.dart';

import '../model/product.dart';
import '../model/convert_item_to_product.dart';
import '../model/product_result.dart';


class ProductsNet extends ProductsSource {

  final http.Client httpClient;

  final String baseUrl = "https://dummyjson.com/products?limit=100";

  ProductsNet({httpClient})
      : this.httpClient = httpClient ?? http.Client();

  Future<List<Product>> getProducts() async {
    final response = await httpClient.get(
      Uri.parse("$baseUrl"),
    );
    final results = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      ProductResult list = ProductResult.fromJson(results);
      return ConvertProductItemToProduct().listToDomainModel(list.productResultsItems);
    } else {
        throw 'Failed to read Json';
    }
  }
}