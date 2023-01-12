import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/product_item.dart';

import '../providers/product.dart';
import '../providers/products.dart';
import '../screens/products_overview_screen.dart';

class ProductsGrid extends StatelessWidget {
  final FilterOptions option;
  ProductsGrid(this.option);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    var products = option == FilterOptions.Favourite
        ? productData.favourites
        : productData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: products[i],
              child: ProductItem(),
            ));
  }
}
