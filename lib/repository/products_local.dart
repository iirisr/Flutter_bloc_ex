import 'package:products_ex/repository/products_source.dart';

import '../model/product.dart';

class ProductsLocal extends ProductsSource {

  ProductsLocal();

  Future<List<Product>> getProducts() async {
    return [
    Product(id: 1, title: "title1",
        price: 120, discountPercentage: 20.5,
        rating: 4.22, stock: 180, category: "category1",
        thumbnail: "https://i.dummyjson.com/data/products/12/thumbnail.jpg",
        images:  ["https://i.dummyjson.com/data/products/12/1.jpg",
          "https://i.dummyjson.com/data/products/12/2.jpg"]),
      Product(id: 2, title: "title2",
          price: 120, discountPercentage: 20.5,
          rating: 4.22, stock: 180, category: "category1",
          thumbnail: "https://i.dummyjson.com/data/products/13/thumbnail.webp",
          images:  ["https://i.dummyjson.com/data/products/13/1.jpg",
            "https://i.dummyjson.com/data/products/13/2.png",
            "https://i.dummyjson.com/data/products/13/3.jpg"]),
      Product(id: 3, title: "title3",
          price: 120, discountPercentage: 20.5,
          rating: 4.22, stock: 180, category: "category2",
          thumbnail: "https://i.dummyjson.com/data/products/14/thumbnail.jpg",
          images:  ["https://i.dummyjson.com/data/products/14/1.jpg"])
    ];
  }
}