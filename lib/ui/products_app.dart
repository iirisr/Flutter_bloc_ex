import 'package:flip_card/flip_card.dart';
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
                  child: Text('No items', style: TextStyle(fontSize: 18)),
                )
              : (state is ProductsStateSuccess)
                 ? Center(
                    child: categories == null
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (BuildContext context, int index) {
                              GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
                              bool backFromProductScreen = false;
                              return Padding(
                                  padding: const EdgeInsets.only(top:8.0, left: 4.0, right: 4.0),
                                  child: Card(
                                    child: Container(
                                      color: Color(0xFFFEEAE6),
                                      height: 300,
                                      child: FlipCard(
                                        key: cardKey,
                                        direction: FlipDirection.HORIZONTAL,
                                        side: CardSide.FRONT,
                                        speed: 1000,
                                        onFlipDone: (status) {
                                           if (backFromProductScreen == false) {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    ProductsScreen(
                                                        repository: widget
                                                            .repository,
                                                        categoryName: categories[index]
                                                            .name
                                                    ),
                                                transitionDuration: Duration(
                                                    seconds: 2),
                                                transitionsBuilder: (_, a, __,
                                                    c) =>
                                                    FadeTransition(
                                                        opacity: a, child: c),
                                              ),
                                            ).then((value) {
                                              print('begin pop, backFromProductScreen=$backFromProductScreen');
                                              if (backFromProductScreen == false) {
                                                backFromProductScreen = true;
                                              }
                                                cardKey.currentState
                                                    ?.toggleCard();
                                            });
                                          }
                                          backFromProductScreen = false;
                                        },
                                        front:  getCategoryCard(context, categories[index].name,
                                                categories[index].thumbnail,
                                                categories[index].sumOfItemsInCategory,
                                                categories[index].sumOfItemsInInventory
                                            ),
                                        back: Container(
                                          color: Color(0xFFEFDCCC),
                                          height: 300,
                                        ),
                                    ),
                                  ),
                                ),
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
