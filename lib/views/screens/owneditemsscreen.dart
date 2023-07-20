import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:barterlt/models/item.dart';
import 'package:barterlt/models/user.dart';
import 'package:barterlt/myconfig.dart';
import 'buyertabscreen.dart'; // Import the BuyerTabScreen to navigate after successful bartering

class OwnedItemsScreen extends StatefulWidget {
  final User user;

  OwnedItemsScreen({required this.user});

  @override
  _OwnedItemsScreenState createState() => _OwnedItemsScreenState();
}

class _OwnedItemsScreenState extends State<OwnedItemsScreen> {
  List<Item> ownedItems = []; // List to store owned items
  List<bool> selectedItems = [];

  String contactName = "";
  String contactEmail = "";
  String contactPhone = "";

  @override
  void initState() {
    super.initState();
    fetchOwnedItems();
  }

  void fetchOwnedItems() async {
    try {
      var response = await http.post(
        Uri.parse("${MyConfig().SERVER}/barterlt/php/load_items.php"),
        body: {
          "userid": widget.user.id,
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'success') {
          List<Item> items = [];
          for (var itemData in jsonData['data']['items']) {
            Item item = Item.fromJson(itemData);
            items.add(item);
            selectedItems.add(false);
          }

          setState(() {
            ownedItems = items;
          });
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Owned Items'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(24.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Select item that you want to barter',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: ownedItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ownedItems[index].itemName ?? ""),
            subtitle: Text("Price: RM ${ownedItems[index].itemPrice ?? ""}"),
            trailing: Checkbox(
              value: selectedItems[index],
              onChanged: (value) {
                setState(() {
                  selectedItems[index] = value!;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          // Handle the barter process here
          List<Item> selectedItemsList = [];
          for (int i = 0; i < ownedItems.length; i++) {
            if (selectedItems[i]) {
              selectedItemsList.add(ownedItems[i]);
            }
          }

          if (selectedItemsList.isEmpty) {
            // No items selected
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text("Please select at least one item to barter."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          } else {
            // User selected items for bartering, show contact information dialog
            showContactInfoDialog(selectedItemsList);
          }
        },
        child: Text("Barter Selected Items"),
      ),
    );
  }

  void showContactInfoDialog(List<Item> selectedItemsList) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Contact Information"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Your Name"),
                onChanged: (value) {
                  setState(() {
                    contactName = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Your Phone"),
                onChanged: (value) {
                  setState(() {
                    contactPhone = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Here, you can use the contact information (contactName, contactEmail, contactPhone)
                // to send an email or any other method of communication with the owner of the selected items.
                // The actual bartering process will take place outside the app based on this contact information.
                // You can also update the database to record the contact information if needed.

                // After the bartering process is completed, you can show a success message to the user.
                // For example:
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Your Barter request had been notified to the owner, please wait for the owner to contact you. Thank you.",
                    ),
                  ),
                );

                // Redirect to BuyerTabScreen after successful bartering
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (content) => BuyerTabScreen(user: widget.user),
                  ),
                );
              },
              child: Text("Barter"),
            ),
          ],
        );
      },
    );
  }
}
