import 'package:flutter/material.dart';
import 'package:github_stonks/universal_variables.dart';

class ChatAndAddToCart extends StatefulWidget {
  @override
  _ChatAndAddToCartState createState() => _ChatAndAddToCartState();
}

class _ChatAndAddToCartState extends State<ChatAndAddToCart> {
  double numOfShares = 0;

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
              value: numOfShares,
              min: 0,
              max: 200,
              divisions: 200,
              label: "$numOfShares"),
          Spacer(),
          TextButton(
            onPressed: () {},
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
