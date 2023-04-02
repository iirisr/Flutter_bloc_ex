import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_ex/bloc/blocLoadItemsBloc.dart';


import 'bloc/blocProductState.dart';
import 'model/category.dart';
import 'repository/products_repository.dart';
import 'widgets/category_card.dart';


class ProductsApp extends StatefulWidget {
  final ProductsRepository repository;
  final String title;

  const ProductsApp({super.key, required this.title, required this.repository});

  @override
  State<ProductsApp> createState() => _ProductsAppState();
}

class _ProductsAppState extends State<ProductsApp> {

  late ProductLoadItemsBloc _productLoadItemsBloc;

  @override initState() {
    super.initState();
    print("_ProductsAppState initState");
    _productLoadItemsBloc = BlocProvider.of<ProductLoadItemsBloc>(context);
    _productLoadItemsBloc.loadProducts();
    /*ProductsNet().getProducts().then((value) { // From before the bloc
      setState(() {
        productsList = value;
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    print("_ProductsAppState build");
    return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
          ),
          body: SafeArea(
              child: CreateProductsList(context)
          ),
    );
  }

  Widget CreateProductsList(BuildContext context) {
    List<Category> categories = widget.repository.getCategories();

    return BlocBuilder(
        bloc: BlocProvider.of<ProductLoadItemsBloc>(context),
        builder: (BuildContext context, ProductsState state) {
          return
            (state is ProductsStateLoading)
            ? Center(
              child: CircularProgressIndicator(color: Colors.indigo,)
              )
            : (state is ProductsStateEmpty)
              ? Center(
                  child: Text('There are no products', style: TextStyle(fontSize: 18)),
                )
              : (state is ProductsStateSuccess)
                 ? Center(
                    child: categories == null
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (BuildContext context, int index) {
                              return getCategoryCard(context, categories[index].name,
                                  categories[index].thumbnail,
                                  categories[index].sumOfItemsInCategory,
                                  categories[index].sumOfItemsInInventory);
                            },
                          ),
                  )
                : Center(
                    child: CircularProgressIndicator(color: Colors.indigo,)
                  );
      }
    );
  }
}
