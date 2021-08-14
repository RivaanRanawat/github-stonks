import 'package:flutter/material.dart';
import 'package:github_stonks/models/product.dart';
import 'package:github_stonks/widgets/buy_shares.dart';
import 'package:github_stonks/widgets/stock_image.dart';
import 'package:github_stonks/universal_variables.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;
  final int index;

  const DetailsScreen({required this.product, required this.index});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(left: kDefaultPadding),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: Text(
          'BACK',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Hero(
                        tag: '${product.id}',
                        child: ProductPoster(
                          size: size,
                          image: product.image,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 2),
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Text(
                      '\$${product.stockPrice}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: kDefaultPadding / 2),
                          child: Text(
                            "${product.sharesAvailable} shares available",
                            style: TextStyle(color: kTextLightColor),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star_border,
                              color: Colors.black,
                            ),
                            Text(
                              product.stars.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: kDefaultPadding),
                  ],
                ),
              ),
              BuyShares(product: product, index: index),
            ],
          ),
        ),
      ),
    );
  }
}
