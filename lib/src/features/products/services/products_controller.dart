import 'package:flutter/material.dart';

import '../models/product_model.dart';
import 'products.dart';

class ProductsController extends ChangeNotifier {
  List<ProductModel>? _products;
  List<String>? _categories;
  bool hasError = false;
  bool isMainLoading = true;
  String errorMessage = '';
  int totalProducts = 0;
  String? _selectedCategory;

  load() async {
    totalProducts = 0;
    isMainLoading = true;
    hasError = false;
    notifyListeners();

    fetchProducts().then((r) {
      if (r.hasError) {
        hasError = true;
        errorMessage = r.message;
      } else {
        _products = r.data as List<ProductModel>;
        totalProducts += _products?.length ?? 0;
      }
      isMainLoading = false;
      notifyListeners();
    });

    fetchCategories().then((r) {
      if (!r.hasError) {
        _categories = r.data as List<String>;
        _selectedCategory = _categories?.first;
      }
      notifyListeners();
    });
  }

  List<ProductModel>? get products => _products;

  List<String>? get categories => _categories;

  String? get selectedCategory => _selectedCategory;

  set selectedCategory(val) {
    _selectedCategory = val;
    notifyListeners();
  }
}
