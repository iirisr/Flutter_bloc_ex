import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_ex/bloc/bloc_product_state.dart';

import 'package:products_ex/repository/products_net.dart';
import 'package:products_ex/repository/products_repository.dart';
import 'package:products_ex/repository/products_source.dart';
import 'bloc/product_bloc.dart';
import 'ui/products_app.dart';

void main() {
  ProductsSource product_source = ProductsNet();
  ProductsRepository productsRepository = ProductsRepository(product_source);
  runApp( MyApp(productsRepository: productsRepository,));
}

class MyApp extends StatelessWidget {
  final ProductsRepository productsRepository;

  const MyApp({Key? key, required this.productsRepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("MyApp:build");
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(
            create: (context) =>
                ProductBloc(productsRepository: productsRepository),
          ),
        ],
        child: BlocBuilder<ProductBloc, ProductsState>(
          builder: (context, state) {
            return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.indigo,
              ),
            home: ProductsApp(title: 'Products App', repository: productsRepository),
            );
          },
        )
    );
  }
}

