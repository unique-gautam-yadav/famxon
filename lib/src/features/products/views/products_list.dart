import 'package:e_commerce/src/features/products/services/products_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../settings/settings_view.dart';
import '../models/product_model.dart';
import '../services/products.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_tile.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    super.key,
  });

  static const routeName = '/';

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductsController>(context, listen: false).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductsController productsController = context.watch<ProductsController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('FamXon Shopping'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Builder(builder: (context) {
          if (productsController.isMainLoading) {
            return Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.surface));
          }

          if (productsController.hasError) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  productsController.errorMessage,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text("retry"),
                ),
              ],
            ));
          }

          List<ProductModel>? items = productsController.products;

          if ((items?.length ?? 0) == 0) {
            return const Center(
                child: Text(
              "No Products found",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
            ));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Trending Products",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  restorationId: 'sampleItemListView',
                  itemCount: items?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final item = items![index];

                    return ProductGrid(item: item);
                  },
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  itemCount: productsController.categories?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        onSelected: (val) {
                          productsController.selectedCategory =
                              productsController.categories!.elementAt(index);
                        },
                        label: Text(
                            productsController.categories!.elementAt(index)),
                        selected: productsController.selectedCategory ==
                            productsController.categories!.elementAt(index),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future:
                      productsByCategory(productsController.selectedCategory!),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                            child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ));
                      case ConnectionState.none:
                        return const Center(
                          child: Text("Error"),
                        );
                      default:
                    }

                    if (snapshot.data?.hasError ?? true) {
                      return Center(
                        child: Column(
                          children: [
                            Text(
                              snapshot.data?.message ?? "Something went wrong",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 50),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.surface,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                productsController.load();
                              },
                              child: const Text("retry"),
                            ),
                          ],
                        ),
                      );
                    }
                    List<ProductModel>? items =
                        snapshot.data?.data as List<ProductModel>?;
                    return ListView.builder(
                      itemCount: items?.length ?? 0,
                      itemBuilder: (context, index) {
                        ProductModel item = items!.elementAt(index);
                        return ProductTile(item: item);
                      },
                    );
                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
