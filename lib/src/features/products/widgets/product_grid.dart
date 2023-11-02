import 'package:flutter/material.dart';

import '../models/product_model.dart';
import 'buy_column.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.item,
  });

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, ProductDetails.routeName, arguments: item);
        buyDialog(context, item);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: SizedBox(
          width: 250,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridTile(
              header: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(12)),
                  ),
                  child: Text(
                    "  \$${item.price.toStringAsFixed(2)}  ",
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              footer: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800.withOpacity(.8),
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(12)),
                ),
                child: Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              child: SizedBox(
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // onTap: () {
              //   Navigator.restorablePushNamed(
              //     context,
              //     ProductDetails.routeName,
              //   );
              // },
            ),
          ),
        ),
      ),
    );
  }
}

Future<dynamic> buyDialog(BuildContext context, ProductModel item) {
  return showModalBottomSheet(
      context: context, builder: (_) => BuyColumn(model: item));
}
