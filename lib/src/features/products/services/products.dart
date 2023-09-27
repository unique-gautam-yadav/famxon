import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../common/models/app_response.dart';
import '../../../meta/meta_data.dart';
import '../models/product_model.dart';

Future<AppResponse> fetchProducts() async {
  try {
    log('message');
    http.Response r = await http.get(Uri.parse('$baseUrl/products'));
    log('fetched');

    switch (r.statusCode) {
      case 404:
        return const AppResponse(
            hasError: true, message: 'Invalid url : Not found!');
      case 200:
        break;
      default:
        return const AppResponse(hasError: true, message: 'Unexpected error');
    }

    return AppResponse(
      hasError: false,
      message: 'ok',
      data: ((jsonDecode(r.body) as Map<String, dynamic>)['products']
              as List<dynamic>)
          .map((e) => ProductModel.fromMap(e))
          .toList(),
    );
  } on SocketException catch (e) {
    debugPrint(e.toString());
    return const AppResponse(hasError: true, message: 'Request Timeout');
  } catch (e) {
    return AppResponse(hasError: true, message: e.toString());
  }
}

Future<AppResponse> fetchCategories() async {
  try {
    log('message');
    http.Response r = await http.get(Uri.parse('$baseUrl/products/categories'));
    log('fetched');

    switch (r.statusCode) {
      case 404:
        return const AppResponse(
            hasError: true, message: 'Invalid url : Not found!');
      case 200:
        break;
      default:
        return const AppResponse(hasError: true, message: 'Unexpected error');
    }

    return AppResponse(
      hasError: false,
      message: 'ok',
      data: List<String>.from(jsonDecode(r.body) as List<dynamic>),
    );
  } on SocketException catch (e) {
    debugPrint(e.toString());
    return const AppResponse(hasError: true, message: 'Request Timeout');
  } catch (e) {
    return AppResponse(hasError: true, message: e.toString());
  }
}

Future<AppResponse> productsByCategory(String category) async {
  try {
    log('message');
    http.Response r = await http
        .get(Uri.parse('$baseUrl/products/category/$category?limit=40'));
    log('fetched');

    switch (r.statusCode) {
      case 404:
        return const AppResponse(
            hasError: true, message: 'Invalid url : Not found!');
      case 200:
        break;
      default:
        return const AppResponse(hasError: true, message: 'Unexpected error');
    }

    return AppResponse(
      hasError: false,
      message: 'ok',
      data: ((jsonDecode(r.body) as Map<String, dynamic>)['products']
              as List<dynamic>)
          .map((e) => ProductModel.fromMap(e))
          .toList(),
    );
  } on SocketException catch (e) {
    debugPrint(e.toString());
    return const AppResponse(hasError: true, message: 'Request Timeout');
  } catch (e) {
    return AppResponse(hasError: true, message: e.toString());
  }
}
