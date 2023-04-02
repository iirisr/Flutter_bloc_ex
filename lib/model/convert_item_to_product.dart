import '../model/product.dart';
import 'product_result.dart';



class ConvertProductItemToProduct {

  Product toDomainModel(ProductResultItem productItem) {
    return Product(
        id: productItem.id,
        title: productItem.title,
        description: productItem.description,
        price: productItem.price,
        discountPercentage: productItem.discountPercentage,
        rating: productItem.rating,
        stock: productItem.stock,
        brand: productItem.brand,
        category: productItem.category,
        thumbnail: productItem.thumbnail,
        images: productItem.images
    );
  }

  List<Product> listToDomainModel(List<ProductResultItem> productsItems) {
    List<Product> list = [];
    for (int i=0; i<productsItems.length; i++) {
      list.add(toDomainModel(productsItems[i]));
    }

    return list;
  }
}