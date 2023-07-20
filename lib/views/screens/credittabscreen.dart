import 'dart:convert';
import 'package:barterlt/myconfig.dart';
import 'package:barterlt/views/screens/profiletabscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../models/user.dart';
import 'mainscreen.dart';

class Credits {
  final int amount;
  final int price;
  final String imagePath;

  Credits({required this.amount, required this.price, required this.imagePath});
}

class CreditTabScreen extends StatefulWidget {
  final User user;

  const CreditTabScreen({super.key, required this.user});

  @override
  State<CreditTabScreen> createState() => _CreditTabScreenState();
}

class _CreditTabScreenState extends State<CreditTabScreen> {
  String maintitle = 'Credit Topup';
  List<Credits> credit = [
    Credits(amount: 20, price: 15, imagePath: 'assets/images/credit_20.png'),
    Credits(amount: 30, price: 25, imagePath: 'assets/images/credit_30.png'),
    Credits(amount: 40, price: 35, imagePath: 'assets/images/credit_40.png'),
    Credits(amount: 50, price: 45, imagePath: 'assets/images/credit_50.png'),
    Credits(amount: 60, price: 55, imagePath: 'assets/images/credit_60.png'),
    Credits(amount: 70, price: 65, imagePath: 'assets/images/credit_70.png'),
    Credits(amount: 80, price: 75, imagePath: 'assets/images/credit_80.png'),
    Credits(amount: 100, price: 85, imagePath: 'assets/images/credit_100.png'),
  ];

  @override
  void initState() {
    super.initState();

    print("Topup");
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
        // Customize the app bar color
      ),
      body: Container(
        // Add a background color or image here
        color: Colors.white,
        child: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: credit.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (widget.user.id.toString() == "na") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please login first."),
                    ),
                  );
                } else {
                  confirmDialog(credit[index]);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      credit[index].imagePath,
                      width: 110, // Set image width as per your requirement
                      height: 110, // Set image height as per your requirement
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${credit[index].amount} Credits',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      'Price: RM ${credit[index].price}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void confirmDialog(Credits credit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Buy Credits",
            style: TextStyle(),
          ),
          content: Text(
            "Are you sure you want to buy\n ${credit.amount} Credit for RM ${credit.price} ?",
            style: const TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                updateCredit(credit);
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

  void updateCredit(Credits credit) async {
    int addCredit = credit.amount;
    String status = "buy";
    http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/update_credit.php"),
        body: {
          "user_id": widget.user.id.toString(),
          "credits": addCredit.toString(),
          "status": status.toString()
        }).then((response) {
      print(response);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Buy Success")));
          Navigator.pop(context);
          Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainScreen(
                              user: widget.user,
                            )));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Buy Failed")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Buy Failed")));
      }
    });
  }
}
