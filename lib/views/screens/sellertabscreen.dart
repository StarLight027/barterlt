import 'package:flutter/material.dart';
import 'package:barterlt/models/user.dart';


// for fisherman screen

class SellerTabScreen extends StatefulWidget {
  final User user;

  const SellerTabScreen({super.key, required this.user});

  @override
  State<SellerTabScreen> createState() => _SellerTabScreenState();
}

class _SellerTabScreenState extends State<SellerTabScreen> {
  late List<Widget> tabchildren;
  String maintitle = "Seller";

  @override
  void initState() {
    super.initState();
    print("Seller");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle),
      ),
    );
  }
}