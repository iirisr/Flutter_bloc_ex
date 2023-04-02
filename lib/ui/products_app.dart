import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:products_ex/ui/category_card.dart';
import 'package:products_ex/ui/products_screen.dart';
import '../bloc/bloc_product_state.dart';
import '../bloc/product_bloc.dart';
import '../model/category.dart';
import '../repository/products_repository.dart';



class ProductsApp extends StatefulWidget {
  final ProductsRepository repository;
  final String title;

  const ProductsApp({super.key, required this.title, required this.repository});

  @override
  State<ProductsApp> createState() => _ProductsAppState();
}

class _ProductsAppState extends State<ProductsApp> {
  late ProductBloc _productBloc;

  @override initState() {
    super.initState();

    _productBloc = BlocProvider.of<ProductBloc>(context);
    _productBloc.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    print("_ProductsAppState build");
    return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: SafeArea(
              child: CreateCategoriesList(context)
          ),
    );
  }

  Widget CreateCategoriesList(BuildContext context) {
    List<Category> categories = widget.repository.getCategories();

    return BlocBuilder(
        bloc: BlocProvider.of<ProductBloc>(context),
        builder: (BuildContext context, ProductsState state) {
          return
            (state is ProductsStateLoading)
            ? Center(
                child: CircularProgressIndicator(color: Colors.indigo,)
              )
            : (state is ProductsStateEmpty)
              ? Center(
                  child: Text('There are no categories', style: TextStyle(fontSize: 18)),
                )
              : (state is ProductsStateSuccess)
                 ? Center(
                    child: categories == null
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder:
                                        (context) => ProductsScreen(
                                          repository: widget.repository,
                                          categoryName: categories[index].name,)),
                                  );
                                },
                                child: getCategoryCard(context, categories[index].name,
                                    categories[index].thumbnail,
                                    categories[index].sumOfItemsInCategory,
                                    categories[index].sumOfItemsInInventory),
                              );
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
