// ignore_for_file: prefer_const_constructors, unused_import, sort_child_properties_last, constant_identifier_names, constant_identifier_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/carts.dart';
import 'package:shop_app/providers/poducts.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions { Filters, All }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var showOnlyFav = false;
  var isInit = true;
  var isLoading = false;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    //Provider.of<Products>(context).fetchAndSetProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    if (isInit) {
      isLoading = true;
      Provider.of<Products>(context).fetchAndSetProducts().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
          actions: [
            PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {
                  setState(() {
                    if (selectedValue == FilterOptions.Filters) {
                      showOnlyFav = true;
                    } else {
                      showOnlyFav = false;
                    }
                  });
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (_) {
                  return [
                    PopupMenuItem(
                        child: Text("Only Favorites"),
                        value: FilterOptions.Filters),
                    PopupMenuItem(
                      child: Text("Show All"),
                      value: FilterOptions.All,
                    ),
                  ];
                }),
            Consumer<Cart>(
              builder: (_, cart, ch) {
                return Badge(
                  child: ch!,
                  value: cart.itemCount.toString(),
                );
              },
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  icon: Icon(Icons.shopping_cart)),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductGrid(showFavs: showOnlyFav));
  }
}
