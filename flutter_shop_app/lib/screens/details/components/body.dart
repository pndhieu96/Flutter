import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constants.dart';
import 'package:flutter_shop_app/models/Product.dart';
import 'package:flutter_shop_app/screens/details/components/add_to_cart.dart';
import 'package:flutter_shop_app/screens/details/components/product_title_with_image.dart';

import 'Counter_with_fav_btn.dart';
import 'Description.dart';
import 'color_and_size.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  // height: 500,
                  margin: EdgeInsets.only(top: size.height * 0.30),
                  padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: kDefaultPaddin,
                      right: kDefaultPaddin),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Column(
                    children: <Widget>[
                      ColorAndSize(product: product),
                      Description(product: product),
                      CounterWithFavBtn(),
                      AddToCart(product: product),
                    ],
                  ),
                ),
                ProductTitleWithImage(product: product, size: size,),
              ],
            )),
      ]),
    );
  }
}
