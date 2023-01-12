import 'package:flutter/material.dart';

import '../providers/product.dart';
import '../widgets/product_item.dart';
import '../widgets/products_grid.dart';

class ProductsOverViewScreen extends StatelessWidget {
  ProductsOverViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My shop'),
      ),
      body: ProductsGrid(),
    );
  }
}
