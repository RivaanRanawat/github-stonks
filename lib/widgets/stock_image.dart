import 'package:flutter/material.dart';
import 'package:github_stonks/universal_variables.dart';

class ProductPoster extends StatelessWidget {
  const ProductPoster({
    required this.size,
    required this.image,
  });

  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      // the height of this container is 80% of our width
      height: size.width * 0.8,

      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: size.width * 0.7,
            width: size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              image,
              height: size.width * 0.75,
              width: size.width * 0.75,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
