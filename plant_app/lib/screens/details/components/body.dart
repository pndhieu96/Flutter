import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/details/components/title_and_price.dart';

import 'bottom_button.dart';
import 'image_and_icon.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          ImageAndIcon(),
          TitleAndPrice(
            title: 'Angelica',
            price: 440,
            country: 'Russsia',
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          BottomButton(size: size),
          SizedBox(
            height: kDefaultPadding * 2,
          ),
        ],
      ),
    );
  }
}
