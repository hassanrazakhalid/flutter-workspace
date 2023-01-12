import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/badge.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../widgets/cart_screen.dart';
import '../widgets/product_item.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { Favourite, ShowAll }

class ProductsOverViewScreen extends StatefulWidget {
  ProductsOverViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  FilterOptions options = FilterOptions.ShowAll;

  void showOnlyFavourite() {
    setState(() {
      options = FilterOptions.Favourite;
    });
  }

  void showAll() {
    setState(() {
      options = FilterOptions.ShowAll;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My shop'),
        actions: [
          PopupMenuButton(
            onSelected: (selectedItem) {
              switch (selectedItem) {
                case FilterOptions.Favourite:
                  showOnlyFavourite();
                  break;
                case FilterOptions.ShowAll:
                  showAll();
                  break;
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only favourite'),
                value: FilterOptions.Favourite,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.ShowAll,
              )
            ],
          ),
          Consumer<Cart>(
            builder: (ctx, cart, ch) => Badge(
              child: ch!,
              color: Colors.pinkAccent,
              value: "${cart.itemsCount}",
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: ProductsGrid(options),
    );
  }
}
