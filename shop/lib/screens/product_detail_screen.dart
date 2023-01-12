import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final arugments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final title = arugments['title']!;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
