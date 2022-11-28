// ignore_for_file: unused_import, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/poducts.dart';
import 'package:shop_app/widgets/products_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavs;
  ProductGrid({required this.showFavs});
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final loadedProducts = showFavs ? productsData.favorites : productsData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: loadedProducts.length,
      itemBuilder: (context, i) {
        return ChangeNotifierProvider.value(
          value: loadedProducts[i],
          child: ProductItem(
              // id: loadedProducts[i].id,
              // title: loadedProducts[i].title,
              // imageUrl: loadedProducts[i].imageUrl
              ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
