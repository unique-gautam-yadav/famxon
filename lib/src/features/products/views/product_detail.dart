import 'package:e_commerce/src/features/products/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.model});

  static const routeName = '/sample_item';
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(model.title),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
