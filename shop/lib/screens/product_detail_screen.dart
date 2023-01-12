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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$${product.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
