import 'package:flutter/material.dart';

import '../../../constants.dart';

class CartCounter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
            icon: Icons.remove,
            press: () {
              if (numOfItems > 1) {
                setState(() {
                  numOfItems--;
                });
              }
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
          child: Text(
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numOfItems++;
              });
            }),
      ],
    );
  }
}

SizedBox buildOutlineButton({IconData icon = Icons.circle, Function()? press}) {
  return SizedBox(
    width: 40,
    height: 32,
    child: OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))),
          padding: MaterialStateProperty.all(EdgeInsets.zero)),
      onPressed: press,
      child: Icon(
        icon,
        color: Colors.black,
      ),
    ),
  );
}