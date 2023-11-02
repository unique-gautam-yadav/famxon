import 'package:e_commerce/src/features/products/widgets/product_grid.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.item,
  });

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // Navigator.pushNamed(context, ProductDetails.routeName, arguments: item);
        buyDialog(context, item);
      },
      leading: AspectRatio(
        // width: 80,
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.thumbnail,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(item.title),
      subtitle: Text("\$${item.price} || ${item.brand}"),
      trailing: Text("⭐ ${item.rating}"),
    );
  }
}
