import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final arugments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final productId = arugments['id']!;
    final products = Provider.of<Products>(context, listen: false);
    final product = products.findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
