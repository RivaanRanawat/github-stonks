import 'package:flutter/material.dart';
import 'package:github_stonks/models/product.dart';
import 'package:github_stonks/providers/ProductsProvider.dart';
import 'package:github_stonks/providers/UserProvider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

void fetchTopStocks(BuildContext context) async {
  var uri = Uri.parse("http://localhost:3001/api/stock-data/all");
        var res = await http.get(
          uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': Provider.of<UserProvider>(context, listen: false)
                .getUserData()
                .token,
          },
        );
        var response = convert.jsonDecode(res.body);
        switch (res.statusCode) {
          case 200:
            response.forEach((element) {
              Product newProd = new Product(
                stockPrice: element["stockPrice"].toDouble(),
                stars: element["stars"],
                id: element["_id"],
                name: element["name"],
                image: element["image"],
                sharesAvailable: element["sharesAvailable"],
              );
              Provider.of<ProductsProvider>(context, listen: false)
                  .setProductData(newProd);
            });
            break;
          case 400:
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response["msg"]),
            ));
            break;
          case 500:
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response["error"]),
            ));
            break;
        }
}

void fetchYourStocks(BuildContext context) async {
  var uri = Uri.parse("http://localhost:3001/api/get-my-stocks");
        var res = await http.get(
          uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': Provider.of<UserProvider>(context, listen: false)
                .getUserData()
                .token,
          },
        );
        var response = convert.jsonDecode(res.body);
        switch (res.statusCode) {
          case 200:
            print(response);
            break;
          case 400:
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response["msg"]),
            ));
            break;
          case 500:
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response["error"]),
            ));
            break;
        }
}