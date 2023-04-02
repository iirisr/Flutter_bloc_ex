import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_product_state.dart';
import '../bloc/product_bloc.dart';
import '../model/product.dart';
import '../repository/products_repository.dart';

class ProductsScreen extends StatefulWidget {
  final ProductsRepository repository;
  final String categoryName;

  const ProductsScreen({super.key, required this.repository, required this.categoryName});

  @override
  State<ProductsScreen> createState()  => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ProductBloc _productBloc;
  late List<Product> _products ;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _products = widget.repository.getProductsForCategory(widget.categoryName);
    for (int i=0; i<_products.length; i++) {
      print(_products[i].title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Container(
        color: Color(0xFFEFDCCC),
        child: CreateProductsList(_products),
      ),
    );
  }

  Widget CreateProductsList(List<Product> products) {
    return BlocBuilder(
        bloc: BlocProvider.of<ProductBloc>(context),
        builder: (BuildContext context, ProductsState state) {
          //_products = widget.repository.getProductsForCategory(widget.categoryName);
          return
            (state is ProductsStateLoading)
            ? Center(
                child: CircularProgressIndicator(color: Colors.indigo,)
            )
            : (state is ProductsStateSuccess)
                ? products == null || products.isEmpty
                  ? Center(
                      child: Text('There are no products', style: TextStyle(fontSize: 18)),
                    )
                  : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = products[index].id;
                      return Dismissible(
                        key: Key(item.toString()),
                        direction: DismissDirection.startToEnd,
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.indigo)
                            ),
                            child: getProductRow(products[index])
                        ),
                        onDismissed: (direction) {
                          _productBloc.removeItem(products[index].id);
                          _products.removeAt(index);
                        },
                        background: Container(color: Colors.red),
                      );
                    },
                  )
                : Text('Errors', style: TextStyle(fontSize: 18));
          });
  }

  Widget getProductRow(Product product) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Price: ${product.price}'),
          Text('Rating: ${product.rating}'),
          SizedBox(height: 8),
          product.thumbnail == null
              ? SizedBox(width: 0,)
              : Flexible(
                  child: CachedNetworkImage(
                    imageUrl: product.thumbnail,
                    placeholder: (context, url) =>  CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>  Icon(Icons.error),
                  ),
                ),
        ]
      ),
    );
  }
}

