import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simple_widgets/model.dart';

import 'detial.dart';

class PageLIst extends StatefulWidget {
  const PageLIst({Key? key, required this.index, required this.product})
      : super(key: key);
  final int index;
  final Product product;
  @override
  State<PageLIst> createState() => _PageLIstState();
}

class _PageLIstState extends State<PageLIst> {
  int? index;
  Product? product;
  @override
  void initState() {
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // // some even current category
    // if (currentCategoryIndex % 2 != 0) {
    //   if (index / 2 == 0) {
    //     return Container();
    //   }
    // }

    //clickable item
    return InkWell(
      onTap: () {
        FocusScopeNode currentScop = FocusScope.of(context);
        if (currentScop.hasPrimaryFocus && currentScop.focusedChild != null) {
          Future.sync(() => FocusScope.of(context).requestFocus(FocusNode()));
          log('$currentScop');
        } else {
          log(' else  ${currentScop.hasPrimaryFocus}');
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return DetailPage(product!);
          }),
        );
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(
          horizontal: 4,
        ),
        child: Stack(
          children: [
            //the product detail
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: product!.bgColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 55),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title
                    Text(
                      product!.name,
                      style: TextStyle(
                          color: product!.nameColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    //detail
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 15),
                      child: Text(
                        product!.details,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //price
                        Flexible(
                          flex: 2,
                          child: Text(
                            product!.price,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Row(
                            children: [
                              //like btn
                              IconButton(
                                icon: product!.liked
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.pink,
                                      )
                                    : const Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.pink,
                                      ),
                                onPressed: () {
                                  if (product!.liked) {
                                    product!.likes = product!.likes - 1;
                                    product!.liked = false;
                                  } else {
                                    product!.likes = product!.likes + 1;
                                    product!.liked = true;
                                  }
                                  setState(() {}); //rebuild
                                },
                              ),
                              //likes
                              Text(
                                product!.likes.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //the image
            Align(
                alignment: FractionalOffset.centerRight,
                child: Hero(
                  tag: product!.name,
                  child: Image.asset(
                    product!.imgUrl,
                    width: 150,
                    fit: BoxFit.fitHeight,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
