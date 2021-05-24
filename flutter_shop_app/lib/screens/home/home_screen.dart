import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constants.dart';
import 'package:flutter_shop_app/screens/home/components/body.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/back.svg", color: kTextColor),
      onPressed: () {},
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {},
        icon: SvgPicture.asset("assets/icons/search.svg", color: kTextColor,)),
      IconButton(
        onPressed: () {},
        icon: SvgPicture.asset("assets/icons/cart.svg", color: kTextColor),
      ),
      SizedBox(
        width: kDefaultPaddin / 2,
      )
    ],
  );
}
