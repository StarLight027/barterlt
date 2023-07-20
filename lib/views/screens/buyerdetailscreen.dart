// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:barterlt/views/screens/billscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:barterlt/models/item.dart';
import 'package:barterlt/models/user.dart';
import 'package:barterlt/myconfig.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

class BuyerDetailsScreen extends StatefulWidget {
  final Item useritem;
  final User user;
  final User seller;
  const BuyerDetailsScreen(
      {super.key,
      required this.useritem,
      required this.user,
      required this.seller});

  @override
  State<BuyerDetailsScreen> createState() => _BuyerDetailsScreenState();
}

class _BuyerDetailsScreenState extends State<BuyerDetailsScreen> {
  int qty = 0;
  int userqty = 1;
  double totalprice = 0.0;
  double singleprice = 0.0;

  @override
  void initState() {
    super.initState();
    qty = int.parse(widget.useritem.itemQty.toString());
    totalprice = double.parse(widget.useritem.itemPrice.toString());
    singleprice = double.parse(widget.useritem.itemPrice.toString());
  }

  final df = DateFormat('dd-MM-yyyy hh:mm a');

  late double screenHeight, screenWidth, cardwitdh;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Item Details")),
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: CarouselSlider(
              options: CarouselOptions(
                height: screenHeight / 2.5,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: [
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "${MyConfig().SERVER}/barterlt/assets/items/1/${widget.useritem.itemId}.png",
                  //${MyConfig().SERVER}/barterlt/assets/items/1/${itemList[index].itemId}.png
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "${MyConfig().SERVER}/barterlt/assets/items/2/${widget.useritem.itemId}.png",
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "${MyConfig().SERVER}/barterlt/assets/items/3/${widget.useritem.itemId}.png",
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.useritem.itemName.toString(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(6),
                    },
                    children: [
                      TableRow(
                        children: [
                          const TableCell(
                            child: Text(
                              "Description",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              widget.useritem.itemDesc.toString(),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const TableCell(
                            child: Text(
                              "Item Type",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              widget.useritem.itemType.toString(),
                            ),
                          ),
                        ],
                      ),
                      TableRow(children: [
                        const TableCell(
                          child: Text(
                            "Quantity Available",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            widget.useritem.itemQty.toString(),
                          ),
                        )
                      ]),
                      TableRow(children: [
                        const TableCell(
                          child: Text(
                            "Price",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            "RM ${double.parse(widget.useritem.itemPrice.toString()).toStringAsFixed(2)}",
                          ),
                        )
                      ]),
                      TableRow(children: [
                        const TableCell(
                          child: Text(
                            "Location",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            "${widget.useritem.itemLocality}/${widget.useritem.itemState}",
                          ),
                        )
                      ]),
                      TableRow(children: [
                        const TableCell(
                          child: Text(
                            "Date",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            df.format(DateTime.parse(
                                widget.useritem.itemDate.toString())),
                          ),
                        )
                      ]),
                      TableRow(children: [
                        const TableCell(
                          child: Text(
                            "Owner",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            widget.seller.name.toString(),
                          ),
                        )
                      ]),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                barterdialog();
              },
              child: const Text("Barter Now!")),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Card(
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          iconSize: 32,
                          onPressed: _makePhoneCall,
                          icon: const Icon(Icons.call)),
                      IconButton(
                          iconSize: 32,
                          onPressed: _makeSmS,
                          icon: const Icon(Icons.message)),
                      IconButton(
                          iconSize: 32,
                          onPressed: openwhatsapp,
                          icon: const Icon(Icons.wechat_outlined)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void barterdialog() {
    if (widget.user.id.toString() == "na") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please register to barter item")));
      return;
    }
    if (widget.user.id.toString() == widget.useritem.userId.toString()) {
      Fluttertoast.showToast(
          msg: "User cannot barter their own item",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("User cannot add own item")));
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Barter this item?",
            style: TextStyle(),
          ),
          content: const Text(
              "Are you sure you want to continue? Please be aware that you may face charges.",
              style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => BillScreen(
                              user: widget.user,
                            )));
                            Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "No",
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

  Future<void> _makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: widget.seller.phone,
    );
    await launchUrl(launchUri);
  }

  Future<void> _makeSmS() async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: widget.seller.phone,
    );
    await launchUrl(launchUri);
  }

  openwhatsapp() async {
    var whatsapp = widget.seller.phone;
    var whatsappURlAndroid =
        "whatsapp://send?phone=$whatsapp&text=Hi! I'd like to barter with you.";
    var whatappURLIos =
        "https://wa.me/$whatsapp?text=${Uri.parse("Hi! I'd like to barter with you.")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURLIos)) {
        await launch(whatappURLIos, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    }
  }
}
