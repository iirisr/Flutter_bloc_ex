import 'package:flutter_test/flutter_test.dart';
import 'package:products_ex/bloc/product_bloc.dart';
import 'package:products_ex/model/convert_item_to_product.dart';
import 'package:products_ex/model/product.dart';
import 'package:products_ex/model/product_result.dart';

void main() {
  late ProductResultItem item1;
  late Product product1, product2;
  late ConvertProductItemToProduct convertProductItemToProduct;
  late ProductBloc productBloc;

  setUp(() {
    convertProductItemToProduct = ConvertProductItemToProduct();

    item1 = ProductResultItem(
      id: 1, title: 'title', description: 'description',
      price: 120, discountPercentage: 20.5, rating: 4.22, stock: 180,
      brand: 'brand', category: 'category',
      thumbnail: "https://i.dummyjson.com/data/products/12/thumbnail.jpg",
      images: ["https://i.dummyjson.com/data/products/12/1.jpg",
        "https://i.dummyjson.com/data/products/12/2.jpg"]);

    product1 = Product(id: item1.id, title: item1.title,
        price: item1.price, discountPercentage: item1.discountPercentage,
        rating: item1.rating, stock: item1.stock, category: item1.category,
        thumbnail: item1.thumbnail,
        images:  item1.images);

    product2 = Product(id: item1.id, title: item1.title,
        price: item1.price, discountPercentage: item1.discountPercentage,
        rating: item1.rating, stock: item1.stock, category: item1.category,
        thumbnail: item1.thumbnail,
        images:  []);
  });

  test('Converting ProductResultItem to Product should succeed', () {
    Product result = convertProductItemToProduct.toDomainModel(item1);

    expect(result, product1);
  });

}
