import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Model/prod_model.dart';

class CartController extends GetxController {
  final _products = {}.obs;

  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }
    Get.snackbar("PRODUCT IS ADDED", "You have added the ${product.p_name} ",
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        // animationDuration: const Duration(seconds: 2),
        backgroundGradient: const LinearGradient(
            colors: [Colors.white, Colors.yellow, Colors.red]));
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }
  }

  get products => _products;

  get productSubtotals => _products.entries
      .map((product) => product.key.p_cost * product.value)
      .toList();

  get totals => _products.entries
      .map((product) => product.key.p_cost * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);
}
