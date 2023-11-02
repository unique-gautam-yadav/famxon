import 'package:flutter/material.dart';

import '../models/product_model.dart';

class BuyColumn extends StatelessWidget {
  const BuyColumn({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: ListView.builder(
              // controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: model.images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.network(
                    model.images.elementAt(index),
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          // Text(model.category),
          const SizedBox(height: 25),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    model.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Rating"),
                    Text(
                      "🌟 ${model.rating}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),
          FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              height: 85,
              decoration: const BoxDecoration(
                  // color: Theme.of(context).primaryColor,
                  ),
              child: SafeArea(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: Text.rich(
                    TextSpan(
                      text: "Buy now for ",
                      children: [
                        TextSpan(
                            text: "\$${(model.price).toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                            ))
                      ],
                    ),
                  ),
                  onPressed: () {
                    //
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
