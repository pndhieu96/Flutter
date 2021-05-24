import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constants.dart';
import 'package:flutter_shop_app/models/Product.dart';
import 'package:flutter_shop_app/screens/details/components/body.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: product.color,
      appBar: buildAppBar(product, context),
      body: Body(product: product,),
    );
  }
}

AppBar buildAppBar(Product product, BuildContext context) {
  return AppBar(
    backgroundColor: product.color,
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset('assets/icons/back.svg', color: Colors.white),
      onPressed: () => Navigator.pop(context),
    ),
    actions: <Widget>[
      IconButton(
        icon: SvgPicture.asset('assets/icons/search.svg'),
        onPressed: () {},
      ),
      IconButton(
        icon: SvgPicture.asset('assets/icons/cart.svg'),
        onPressed: () {},
      ),
      SizedBox(width: kDefaultPaddin/2,)
    ],
  );
}
