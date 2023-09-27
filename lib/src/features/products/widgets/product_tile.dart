import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../views/product_detail.dart';

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
        Navigator.pushNamed(context, ProductDetails.routeName, arguments: item);
      },
      leading: SizedBox(
        width: 80,
        child: Image.network(
          item.thumbnail,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(item.title),
      subtitle: Text("\$${item.price} || ${item.brand}"),
      trailing: Text("⭐ ${item.rating}"),
    );
  }
}
