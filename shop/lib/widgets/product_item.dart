import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/product_detail_screen.dart';

import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(product.isFavourite
                ? Icons.favorite
                : Icons.favorite_outline_outlined),
            color: Theme.of(context).accentColor,
            onPressed: () {
              product.toggeleFavourite();
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => ProductDetailScreen(
            //       title: title,
            //     ),
            //   ),
            // );
            Navigator.of(context).pushNamed(ProductDetailScreen.routName,
                arguments: {'id': product.id});
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
