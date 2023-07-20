import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:barterlt/models/user.dart';
import '../../myconfig.dart';
import 'owneditemsscreen.dart';

class BillScreen extends StatefulWidget {
  final User user;

  BillScreen({required this.user});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  int currentCredit = 0;

  @override
  void initState() {
    super.initState();
    currentCredit = int.tryParse(widget.user.credit ?? '') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deduct Credits'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              onTap: () {},
              selected: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
              title: Text(
                "Credit Deduction for Barter Transactions",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                "To continue this transaction, please pay 10 Credits",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Current Credit: $currentCredit',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                deductCredit();
              },
              child: Text('Deduct 10 Credits'),
            ),
          ],
        ),
      ),
    );
  }

  void deductCredit() async {
    int amountToDeduct = 10;
    int userCredit = currentCredit; // Store the current credit in a separate variable

    if (userCredit >= amountToDeduct) {
      int newCredit = userCredit - amountToDeduct;
      String status = 'pay';
      showInfoBottomSheet();

      http.post(
        Uri.parse("${MyConfig().SERVER}/barterlt/php/update_credit.php"),
        body: {
          "user_id": widget.user.id!,
          "credits": newCredit.toString(),
          "status": status,
        },
      ).then((response) {
        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body);
          if (jsonData['status'] == 'success') {
            // Credit deducted successfully, update the user object and current credit
            setState(() {
              currentCredit = newCredit;
              widget.user.credit = newCredit.toString();
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Credit Deducted Successfully")),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to Deduct Credit")),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to Deduct Credit")),
          );
        }
      });
    } else if (userCredit == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please Top-up Credit First")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Insufficient Credit")),
      );
    }
  }

  void showInfoBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Credit Deduction Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'The credits deducted will be used to secure the transaction and cover the fees for the barter transaction.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OwnedItemsScreen(user: widget.user),
                    ),
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}
