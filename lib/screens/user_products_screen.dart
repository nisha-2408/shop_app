// ignore_for_file: prefer_const_constructors, unused_import, avoid_web_libraries_in_flutter


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/poducts.dart';
import 'package:shop_app/screens/edit_products_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});
  static const routeName = "/user-products";
  Future<void> refreshProducts(BuildContext context) async{
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: [IconButton(onPressed: () {
          Navigator.of(context).pushNamed(EditProductsScreen.routeName);
        }, icon: Icon(Icons.add))],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (ctx, i) {
              return Column(
                children: [
                  UserProductItem(
                      id: products.items[i].id,
                      title: products.items[i].title,
                      imageUrl: products.items[i].imageUrl),
                  Divider()
                ],
              );
            },
            itemCount: products.items.length,
          ),
        ),
      ),
    );
  }
}
