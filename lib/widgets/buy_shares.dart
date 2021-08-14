import 'package:flutter/material.dart';
import 'package:github_stonks/models/User.dart';
import 'package:github_stonks/models/product.dart';
import 'package:github_stonks/providers/ProductsProvider.dart';
import 'package:github_stonks/providers/UserProvider.dart';
import 'package:github_stonks/universal_variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:provider/provider.dart';

class BuyShares extends StatefulWidget {
  final Product product;
  final int index;
  BuyShares({required this.product, required this.index});

  @override
  _BuySharesState createState() => _BuySharesState();
}

class _BuySharesState extends State<BuyShares> {
  double numOfShares = 1;

  void buyShare(double sharesBought) async {
    try {
      var uri = Uri.parse("http://localhost:3001/api/buy-stock");
      int sharesInt = sharesBought.round();
      var res = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': Provider.of<UserProvider>(context, listen: false)
                .getUserData()
                .token
          },
          body: convert.jsonEncode(<String, String>{
            "name": widget.product.name,
            "noOfSharesBought": sharesInt.toString()
          }));

      var response = convert.jsonDecode(res.body);

      switch (res.statusCode) {
        case 200:
          print(response);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text("Bought $sharesInt shares of ${widget.product.name}"),
            ),
          );
          Product newProduct = new Product(
            id: response["_id"],
            image: response['image'],
            name: response['name'],
            sharesAvailable: response["sharesAvailable"],
            stars: response["stars"],
            stockPrice: response["stockPrice"],
          );
          Provider.of<ProductsProvider>(context, listen: false)
              .setProductDataByIndex(widget.index, newProduct);
          Navigator.of(context).pop();
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
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: <Widget>[
          Slider(
            activeColor: Colors.white,
            onChanged: (double value) {
              setState(() {
                numOfShares = value;
              });
            },
            value: numOfShares.toDouble(),
            min: 1,
            max: widget.product.sharesAvailable.toDouble() - 1,
            divisions: widget.product.sharesAvailable,
            label: numOfShares.toStringAsFixed(2),
          ),
          Spacer(),
          TextButton(
            onPressed: () => buyShare(numOfShares),
            child: Text(
              "BUY",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
