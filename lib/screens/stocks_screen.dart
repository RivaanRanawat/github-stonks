import 'package:flutter/material.dart';
import 'package:github_stonks/models/product.dart';
import 'package:github_stonks/providers/ProductsProvider.dart';
import 'package:github_stonks/providers/UserProvider.dart';
import 'package:github_stonks/screens/details_screen.dart';
import 'package:github_stonks/universal_variables.dart';
import 'package:github_stonks/utils/mongo_db_repo.dart';
import 'package:github_stonks/widgets/category_list.dart';
import 'package:github_stonks/widgets/stocks_card.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StocksScreen extends StatefulWidget {
  @override
  _StocksScreenState createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  @override
  void initState() {
    getProductsData();
    super.initState();
  }

  getProductsData() async {
    try {
      var updateGithubUrl =
          Uri.parse("http://localhost:3001/api/update-github-repos");
      var githubRepoRes = await http.get(
        updateGithubUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': Provider.of<UserProvider>(context, listen: false)
              .getUserData()
              .token,
        },
      );
      if (githubRepoRes.statusCode == 200) {
        fetchTopStocks(context);
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsList = Provider.of<ProductsProvider>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: purpleColor,
          centerTitle: false,
          title: Text('Top Repositories'),
        ),
        backgroundColor: purpleColor,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(kDefaultPadding),
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  onChanged: (value) {},
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    icon: Icon(Icons.search),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              CategoryList(),
              SizedBox(height: kDefaultPadding / 2),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    productsList.getProductslist().isNotEmpty
                        ? ListView.builder(
                            itemCount: productsList.getProductslist().length,
                            itemBuilder: (context, index) => StocksCard(
                              itemIndex: index,
                              product: productsList.getProductData(index),
                              onPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      product:
                                          productsList.getProductData(index),
                                          index: index
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(color: purpleColor,),
                          ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
