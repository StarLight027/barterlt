import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:barterlt/models/cart.dart';
import 'package:barterlt/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:barterlt/myconfig.dart';

class BuyerCartScreen extends StatefulWidget {
  final User user;

  const BuyerCartScreen({super.key, required this.user});

  @override
  State<BuyerCartScreen> createState() => _BuyerCartScreenState();
}

class _BuyerCartScreenState extends State<BuyerCartScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
