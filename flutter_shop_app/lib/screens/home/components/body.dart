import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constants.dart';
import 'package:flutter_shop_app/models/Product.dart';
import 'package:flutter_shop_app/screens/details/details_screen.dart';

import 'categories.dart';
import 'item_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: Text(
              "Women",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Categories(),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75),
              itemCount: Product.products.length,
              itemBuilder: (context, index) => ItemCard(
                product: Product.products[index],
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailsScreen(product: Product.products[index]),
                    )),
              ),
            ),
          )),
        ]);
  }
}
