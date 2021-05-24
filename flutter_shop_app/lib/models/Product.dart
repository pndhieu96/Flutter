import 'package:flutter/material.dart';

class Product {
  final String image;
  final String title;
  final String description;
  final int price;
  final int size;
  final int id;
  final Color color;

  Product(this.id, this.title, this.price, this.size, this.description,
      this.image, this.color);

  static List<Product> products = [
    Product(1, "Office Code", 234, 12, dummyText, "assets/images/bag_1.png",
        Color(0xFF3D82AE)),
    Product(2, "Belt Bag", 234, 8, dummyText, "assets/images/bag_2.png",
        Color(0xFFD3A984)),
    Product(3, "Hang Top", 234, 10, dummyText, "assets/images/bag_3.png",
        Color(0xFF989493)),
    Product(4, "Old Fashion", 234, 11, dummyText, "assets/images/bag_4.png",
        Color(0xFFE6B398)),
    Product(5, "Office Code", 234, 12, dummyText, "assets/images/bag_5.png",
        Color(0xFFFB7883)),
    Product(6, "Office Code", 234, 12, dummyText, "assets/images/bag_6.png",
        Color(0xFFAEAEAE),
    ),
  ];
}

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
