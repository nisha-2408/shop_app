// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/carts.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/providers/poducts.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_products_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/prodcuts_details_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            colorScheme: Theme.of(context)
                .colorScheme
                .copyWith(primary: Colors.purple, secondary: Colors.deepOrange),
            fontFamily: 'Lato'),
        home: ProductOverviewScreen(),
        routes: {
          ProductsDetailsScreen.routeName: (context) => ProductsDetailsScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: ((context) => OrdersScreen()),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          EditProductsScreen.routeName:(context) => EditProductsScreen()
        },
      ),
    );
  }
}
