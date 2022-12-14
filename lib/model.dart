import 'dart:ui';

class Product {
  //members
  int? id;
  String name, details, price, imgUrl;
  int likes;
  Color bgColor, nameColor;
  bool liked;
  //constructor
  Product(this.id, this.name, this.details, this.price, this.imgUrl, this.likes,
      {this.bgColor = const Color(0XFFf8efac),
      this.nameColor = const Color(0Xffb8954d),
      this.liked = false});
}
