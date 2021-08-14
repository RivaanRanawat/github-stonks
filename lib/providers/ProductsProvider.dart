import 'package:flutter/material.dart';
import 'package:github_stonks/models/product.dart';

class ProductsProvider extends ChangeNotifier {
  Product product = new Product(id: '', image: '', name: '', stars: 0, stockPrice: 0,sharesAvailable: 0);
  List<Product> productsList = [];

  void setProductData(Product newProduct) {
    product = newProduct;
    productsList.add(product);
    notifyListeners();
  }

  Product getProductData(int index) {
    return productsList[index];
  }

  List<Product> getProductslist() {
    return productsList;
  }

  void setProductDataByIndex(int index, Product newProduct) {
    productsList[index] = newProduct;
    notifyListeners();
  }
}
