import 'package:flutter/material.dart';
import 'package:github_stonks/universal_variables.dart';
import 'package:github_stonks/utils/mongo_db_repo.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;
  List categories = ['Top Stocks', 'Your Stocks', 'Trending Stocks'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            switch (index) {
              case 0:
                // Top Stocks
                fetchTopStocks(context);
                break;
              case 1:
                // Your Stocks
                fetchYourStocks(context);
                break;
              case 2:
                // Trending Stocks
                break;
            }
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: kDefaultPadding,
              right: index == categories.length - 1 ? kDefaultPadding : 0,
            ),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              color: index == selectedIndex
                  ? Colors.white.withOpacity(0.4)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              categories[index],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
