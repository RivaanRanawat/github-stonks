import 'package:flutter/material.dart';
import 'package:github_stonks/models/product.dart';

class ProductsProvider extends ChangeNotifier {
  Product _product = new Product(id: '', image: '', name: '', stars: 0, stockPrice: 0,sharesAvailable: 0);
  List<Product> _productsList = [];

  void setProductData(Product newProduct) {
    _product = newProduct;
    _productsList.add(_product);
    notifyListeners();
  }

  Product getProductData(int index) {
    return _productsList[index];
  }

  List<Product> getProductslist() {
    return _productsList;
  }

  void setProductDataByIndex(int index, Product newProduct) {
    _productsList[index] = newProduct;
    notifyListeners();
  }
}
