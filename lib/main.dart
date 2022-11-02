import 'dart:developer';

import 'package:flutter/material.dart';

import 'detial.dart';
import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Juice App'),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //start working here
  //members
  List<String> categories = [
    "All",
    "Recommended",
    "Special Order",
    "Fresh Juice",
    "Trending",
    "Customize"
  ];
  int currentCategoryIndex = 0;
  bool searching = false;
  final _searchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  int page = 1;
  int pageCount = 20;
  int startAt = 0;
  int? endAt;
  int totalPages = 0;

  final List<Product> _products = [];
  List<Product> filteredProducts = [];
  var detail =
      "Introducing the all-new Platform for retailers, entrepreneurs and ecommerce professionals. Tune in for expert insights, strategies and tactics to help grow your business. ";

  @override
  void initState() {
    //add products
    _products.add(Product(
        100,
        "Apple Juice",
        detail,
        "\$3.9",
        "asset/peach-transparent-background-image-11577026412dvnaixevyo.png",
        898,
        bgColor: const Color(0xfff57888),
        nameColor: const Color(0xff9a0c1e)));
    _products.add(Product(100, "Green Apple Juice", detail, "\$2.8",
        "asset/Fruit-PNG-Picture.png", 158,
        bgColor: const Color(0XFFdeefa3), nameColor: const Color(0XFF86a51d)));
    _products.add(Product(100, "Mango Juice", detail, "\$1.5",
        "asset/4-48879_fruit-png-fruits-png.png", 1500,
        bgColor: const Color(0xfffde197), nameColor: const Color(0xffeeae04)));
    _products.add(Product(300, "Papaya Juice", detail, "\$3.5",
        "asset/Fruit-PNG-Picture.png", 459,
        bgColor: const Color(0XFFfecdaf), nameColor: const Color(0xffae4302)));
    _products.add(Product(200, "Strawberry", detail, "\$4.2",
        "asset/4-48879_fruit-png-fruits-png.png", 120,
        bgColor: const Color(0XFFfca9ad), nameColor: const Color(0Xffc40610)));
    _products.add(Product(200, "Orange Juice", detail, "\$1.9",
        "asset/4-48879_fruit-png-fruits-png.png", 20000,
        bgColor: const Color(0Xfffecb7e), nameColor: const Color(0XFFe38902)));
    _products.add(Product(
        300,
        "Apple Juice",
        detail,
        "\$3.9",
        "asset/peach-transparent-background-image-11577026412dvnaixevyo.png",
        898,
        bgColor: const Color(0xfff57888),
        nameColor: const Color(0xff9a0c1e)));
    _products.add(Product(100, "Green Apple Juice", detail, "\$2.8",
        "asset/Fruit-PNG-Picture.png", 158,
        bgColor: const Color(0XFFdeefa3), nameColor: const Color(0XFF86a51d)));
    _products.add(Product(100, "Mango Juice", detail, "\$1.5",
        "asset/4-48879_fruit-png-fruits-png.png", 1500,
        bgColor: const Color(0xfffde197), nameColor: const Color(0xffeeae04)));
    _products.add(Product(300, "Papaya Juice", detail, "\$3.5",
        "asset/Fruit-PNG-Picture.png", 459,
        bgColor: const Color(0XFFfecdaf), nameColor: const Color(0xffae4302)));
    _products.add(Product(200, "Strawberry", detail, "\$4.2",
        "asset/4-48879_fruit-png-fruits-png.png", 120,
        bgColor: const Color(0XFFfca9ad), nameColor: const Color(0Xffc40610)));
    _products.add(Product(200, "Orange Juice", detail, "\$1.9",
        "asset/4-48879_fruit-png-fruits-png.png", 20000,
        bgColor: const Color(0Xfffecb7e), nameColor: const Color(0XFFe38902)));

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // void loadNextPage() {
  //   if (page < totalPages) {
  //     setState(() {
  //       startAt = startAt;
  //       endAt = _products.length > endAt! + pageCount
  //           ? endAt! + pageCount
  //           : _products.length;
  //       currentDataList = dataList.getRange(startAt, endAt!).toList();
  //       page = page + 1;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        backgroundColor: Colors.orange,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 50),
            child: Icon(Icons.print),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _searchFieldContainer(),
        _buildCategories(),
        _buildPageTitle(),
        _buildProductsListview(searching || _searchController.text.isNotEmpty
            ? filteredProducts
            : _products),
      ],
    );
  }

  Widget _searchFieldContainer() {
    return SizedBox(
      height: 52,
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
        width: MediaQuery.of(context).size.width * .8,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Color(0xfff4f4f4), //f0f0f0
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: TextField(
                controller: _searchController,
                focusNode: focusNode,
                onChanged: (value) {
                  if (!searching) {
                    searching = true;
                  }
                  //do the search here
                  filter(value);
                  setState(() {}); //ensure dirty tree is rebuilt
                },
                style: const TextStyle(),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    )),
              ),
            ),
            Flexible(
              child: IconButton(
                icon: Icon(
                  searching ? Icons.close : Icons.search,
                  color: Colors.black26,
                ),
                onPressed: () {
                  if (searching) {
                    FocusScope.of(context).requestFocus(
                        FocusNode()); //hide keyboard ie dedicating focus to another node
                    _searchController.text = "";
                    filteredProducts.clear(); //ensure search results is clean
                  } else {
                    //request focus to the search field
                    FocusScope.of(context).requestFocus(focusNode);
                  }
                  searching = !searching;
                  setState(() {}); //rebuild dirty tree
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //filter
  void filter(String query) {
    if (_products.isNotEmpty) {
      filteredProducts.clear(); //clear the result list
      for (Product product in _products) {
        if (product.name.toLowerCase().contains(query.toLowerCase())) {
          filteredProducts.add(product);
        }
      }
    }
  }

  void chooseCartegory(int query) {
    if (_products.isNotEmpty) {
      filteredProducts.clear(); //clear the result list
      for (Product product in _products) {
        if (product.id
            .toString()
            .toLowerCase()
            .contains(query.toString().toUpperCase())) {
          filteredProducts.add(product);

          var contains1 = _products.any((element) =>
              element.id.toString().contains(query.toString().toUpperCase()));
          if (contains1 == true) {
            log('$contains1');
          } else if (contains1 == false) {
            log('$contains1');
          }
        }
      }
    }
  }

  Widget _buildCategories() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SizedBox(
          height: 30,
          child: ListView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return currentCategoryIndex == index
                    ? _buildCurrentCategory(index)
                    : _buildCategory(index);
              }),
        ));
  }

  Widget _buildCurrentCategory(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        categories.elementAt(index),
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
    );
  }

  Widget _buildCategory(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          currentCategoryIndex = index;

          switch (index) {
            case 0:
              searching = false;
              break;
            case 1:
              searching = true;
              chooseCartegory(100);
              break;
            case 3:
              searching = true;
              chooseCartegory(200);

              break;
            case 5:
              searching = true;
              chooseCartegory(300);
              break;
            default:
              searching = true;
              chooseCartegory(1234567);
          }

          // if (index == 2) {
          //   searching = true;

          //   setState(() {});
          //   chooseCartegory(100);
          // } else if (index == 1) {
          //   searching = true;

          //   chooseCartegory(200);
          // } else if (index == 0) {
          //   // _searchController.text = "";
          // } else {
          //   searching = true;
          //   chooseCartegory("400");
          // }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          categories.elementAt(index),
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }

  Widget _buildPageTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xfff0f0f0)))),
      child: Text(
        categories[currentCategoryIndex] + " Juice",
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildProductsListview(List<Product> products) {
    return Expanded(
      //important
      child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 10),
          itemCount: products.length,
          itemBuilder: (context, index) {
            Product product = products.elementAt(index);

            return _buildProductItem(index, product);
          }),
    );
  }

  Widget _buildProductItem(int index, Product product) {
    // some even current category
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
            return DetailPage(product);
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
                color: product.bgColor,
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
                      product.name,
                      style: TextStyle(
                          color: product.nameColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    //detail
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 15),
                      child: Text(
                        product.details,
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
                            product.price,
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
                                icon: product.liked
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.pink,
                                      )
                                    : const Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.pink,
                                      ),
                                onPressed: () {
                                  if (product.liked) {
                                    product.likes = product.likes - 1;
                                    product.liked = false;
                                  } else {
                                    product.likes = product.likes + 1;
                                    product.liked = true;
                                  }
                                  setState(() {}); //rebuild
                                },
                              ),
                              //likes
                              Text(
                                product.likes.toString(),
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
                  tag: product.name,
                  child: Image.asset(
                    product.imgUrl,
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

class Data {
  String? name;
  int? id;
  Data({this.id, this.name});
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  final ScrollController scrollController = ScrollController();
  final List<Data> dataList = <Data>[
    Data(name: "A", id: 1),
    Data(name: "B", id: 2),
    Data(name: "C", id: 3)
  ];
  List<Data> currentDataList = <Data>[];
  int page = 1;
  int pageCount = 20;
  int startAt = 0;
  int? endAt;
  int totalPages = 0;

  @override
  void initState() {
    for (var i = 1; i <= 200; i++) dataList.add(Data(name: "Test - $i", id: i));

    endAt = startAt + pageCount;
    totalPages = (dataList.length / pageCount).floor();
    if (dataList.length / pageCount > totalPages) {
      totalPages = totalPages + 1;
    }

    currentDataList = dataList.getRange(startAt, endAt!).toList();
    initScroll();

    super.initState();
  }

  void initScroll() {
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        log("${scrollController.position.maxScrollExtent}");
        loadNextPage();
      }
    });
  }

  void loadPreviousPage() {
    if (page > 1) {
      setState(() {
        startAt = startAt - pageCount;
        endAt = page == totalPages
            ? endAt! - currentDataList.length
            : endAt! - pageCount;
        currentDataList = dataList.getRange(startAt, endAt!).toList();
        page = page - 1;
      });
    }
  }

  void loadNextPage() {
    if (page < totalPages) {
      setState(() {
        startAt = startAt;
        endAt = dataList.length > endAt! + pageCount
            ? endAt! + pageCount
            : dataList.length;
        currentDataList = dataList.getRange(startAt, endAt!).toList();
        page = page + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagination'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: currentDataList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Text(
                      "${currentDataList[index].name} ${currentDataList[index].id.toString()}"),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: page > 1 ? loadPreviousPage : null,
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                ),
              ),
              Text("$page / $totalPages"),
              IconButton(
                onPressed: page < totalPages ? loadNextPage : null,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 35,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
