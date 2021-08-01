import 'package:flutter/material.dart';
import 'package:github_stonks/universal_variables.dart';

class BuyShares extends StatefulWidget {
  final int shares;
  BuyShares({required this.shares});
  @override
  _BuySharesState createState() => _BuySharesState();
}

class _BuySharesState extends State<BuyShares> {
  double numOfShares = 1;

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
            max: widget.shares.toDouble(),
            divisions: widget.shares,
            label: numOfShares.toStringAsFixed(2),
          ),
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
