import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/item.dart';
import 'package:barterlt/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:barterlt/myconfig.dart';

import 'buyercartscreen.dart';
import 'buyerdetailscreen.dart';

//for buyer screen

class BuyerTabScreen extends StatefulWidget {
  final User user;
  const BuyerTabScreen({super.key, required this.user});

  @override
  State<BuyerTabScreen> createState() => _BuyerTabScreenState();
}

class _BuyerTabScreenState extends State<BuyerTabScreen> {
  String maintitle = "Buyer";
  List<Item> itemList = <Item>[];
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  int numofpage = 1, curpage = 1;
  int numberofresult = 0;
  var color;
  int cartqty = 0;

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadItems(1);
    print("Buyer");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle),
        actions: [
          IconButton(
              onPressed: () {
                showsearchDialog();
              },
              icon: const Icon(Icons.search)),
          TextButton.icon(
            icon: const Icon(
              Icons.shopping_cart,
            ), // Your icon here
            label: Text(cartqty.toString()), // Your text here
            onPressed: () {
              if (cartqty > 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => BuyerCartScreen(
                              user: widget.user,
                            )));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No item in cart")));
              }
            },
          )
          // Stack(
          //   alignment: Alignment.topRight,
          //   children: [
          //     IconButton(
          //         onPressed: () {},
          //         icon: const Icon(
          //           Icons.shopping_cart,
          //         )),
          //     Positioned(
          //         right: 30,
          //         bottom: 25,
          //         child: Text(
          //           cartqty.toString(),
          //           style: const TextStyle(color: Colors.red, fontSize: 18),
          //         )),
          //   ],
          // )
          // IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.shopping_cart,
          //     )),
          // Text(cartqty.toString()),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: itemList.isEmpty
            ? const Center(
                child: Text("No Data"),
              )
            : Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                      height: 24,
                      color: Theme.of(context).colorScheme.primary,
                      width: 300,
                      alignment: Alignment.center,
                      child: Text(
                        "${itemList.length} Items Found",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListTile(
                      onTap: () {},
                      selected: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      selectedTileColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      title: Text(
                        "Welcome to BarterIt",
                        style: Theme.of(context).textTheme.titleMedium!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                      ),
                      subtitle: Text(
                        "An innovative online barter application",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                              ),
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: axiscount,
                        childAspectRatio:
                            3 / 4, // Adjust the aspect ratio as needed
                      ),
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              Item useritem =
                                  Item.fromJson(itemList[index].toJson());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (content) => BuyerDetailsScreen(
                                            user: widget.user,
                                            useritem: useritem,
                                          )));
                              loadItems(1);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0),
                                    ),
                                    child: CachedNetworkImage(
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "${MyConfig().SERVER}/barterlt/assets/items/1/${itemList[index].itemId}.png",
                                      placeholder: (context, url) =>
                                          const LinearProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        itemList[index].itemName.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "RM ${double.parse(itemList[index].itemPrice.toString()).toStringAsFixed(2)}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${itemList[index].itemQty} available",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: numofpage,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        //build the list for textbutton with scroll
                        if ((curpage - 1) == index) {
                          //set current page number active
                          color = Colors.blue;
                        } else {
                          color = Colors.black;
                        }
                        return TextButton(
                            onPressed: () {
                              curpage = index + 1;
                              loadItems(index + 1);
                            },
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(color: color, fontSize: 18),
                            ));
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void loadItems(int pg) {
    http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/load_items.php"),
        body: {
          //"cartuserid": widget.user.id,
          "pageno": pg.toString()
        }).then((response) {
      //print(response.body);
      //log(response.body);
      itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          numofpage = int.parse(jsondata['numofpage']); //get number of pages
          numberofresult = int.parse(jsondata['numberofresult']);
          print(numberofresult);
          var extractdata = jsondata['data'];
          //cartqty = int.parse(jsondata['cartqty'].toString());
          //print(cartqty);
          extractdata['items'].forEach((v) {
            itemList.add(Item.fromJson(v));
          });
          print(itemList[0].itemName);
        }
        setState(() {});
      }
    });
  }

  void showsearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Search?",
            style: TextStyle(),
          ),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    labelText: 'Search',
                    labelStyle: TextStyle(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0),
                    ))),
            const SizedBox(
              height: 4,
            ),
            ElevatedButton(
                onPressed: () {
                  String search = searchController.text;
                  searchItem(search);
                  Navigator.of(context).pop();
                },
                child: const Text("Search"))
          ]),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Close",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void searchItem(String search) {
    http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/load_items.php"),
        body: {
          //"cartuserid": widget.user.id,
          "search": search
        }).then((response) {
      //print(response.body);
      log(response.body);
      itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['items'].forEach((v) {
            itemList.add(Item.fromJson(v));
          });
          print(itemList[0].itemName);
        }
        setState(() {});
      }
    });
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      loadItems(1);
    });
  }
}
