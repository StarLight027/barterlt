import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:barterlt/myconfig.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();
  late double screenHeight, screenWidth, cardWidth;
  bool _isPasswordVisible = false;
  bool _isReenterPasswordVisible = false;

  final Color _shadowColor = Colors.deepPurple.withOpacity(0.4);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    cardWidth = screenWidth * 0.8;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Registration",
            style: TextStyle(color: Colors.blueAccent)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.deepPurple),
        foregroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.35,
              width: screenWidth,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.lightBlue,
                    Colors.white,
                  ],
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/register.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: _shadowColor,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Container(
                  width: cardWidth,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameEditingController,
                              validator: (val) => val!.isEmpty || val.length < 5
                                  ? "Name must be longer than 5 characters"
                                  : null,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                icon: Icon(Icons.person),
                              ),
                            ),
                            TextFormField(
                              controller: _phoneEditingController,
                              validator: (val) => val!.isEmpty ||
                                      val.length < 10
                                  ? "Phone must be longer or equal than 10 characters"
                                  : null,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Phone',
                                icon: Icon(Icons.phone),
                              ),
                            ),
                            TextFormField(
                              controller: _emailEditingController,
                              validator: (val) => val!.isEmpty ||
                                      !val.contains('@') ||
                                      !val.contains('.')
                                  ? "Enter a valid email"
                                  : null,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                icon: Icon(Icons.email),
                              ),
                            ),
                            TextFormField(
                              controller: _passEditingController,
                              validator: (val) => val!.isEmpty || val.length < 5
                                  ? "Password must be longer than 5 characters"
                                  : null,
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                icon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: _togglePasswordVisibility,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _pass2EditingController,
                              validator: (val) => val!.isEmpty || val.length < 5
                                  ? "Password must be longer than 5 characters"
                                  : null,
                              obscureText: !_isReenterPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Re-enter password',
                                icon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isReenterPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: _toggleReenterPasswordVisibility,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Checkbox(
                                  value: _isChecked,
                                  onChanged: (bool? value) {
                                    if (!_isChecked) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Terms have been read and accepted.",
                                          ),
                                        ),
                                      );
                                    }
                                    setState(() {
                                      _isChecked = value!;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  onTap: _showTermsDialog,
                                  child: const Text(
                                    'Agree with terms',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              minWidth: screenWidth / 3,
                              height: 40,
                              elevation: 10,
                              onPressed: onRegisterDialog,
                              color: Theme.of(context).primaryColor,
                              textColor: Theme.of(context).colorScheme.onError,
                              child: const Text(
                                'Register', 
                                style: TextStyle(fontSize: 17),
                            ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _goLogin,
                        child: const Text(
                          "Already Registered? Login",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleReenterPasswordVisibility() {
    setState(() {
      _isReenterPasswordVisible = !_isReenterPasswordVisible;
    });
  }

  void onRegisterDialog() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Check your input")),
      );
      return;
    }
    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please agree with terms and conditions")),
      );
      return;
    }
    String passa = _passEditingController.text;
    String passb = _pass2EditingController.text;
    if (passa != passb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Check your password")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: const Text(
            "Register new account?",
          ),
          content: const Text("Are you sure?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                registerUser();
              },
            ),
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void registerUser() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text("Please Wait"),
          content: Text("Registration..."),
        );
      },
    );

    String name = _nameEditingController.text;
    String email = _emailEditingController.text;
    String phone = _phoneEditingController.text;
    String passa = _passEditingController.text;

    http.post(
      Uri.parse("${MyConfig().SERVER}/barterlt/php/register_user.php"),
      body: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": passa,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration Success")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration Failed")),
          );
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Failed")),
        );
      }
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error")),
      );
    });
  }

  void _goLogin() {
    Navigator.of(context).pop();
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Terms and Conditions"),
          content: SingleChildScrollView(
            child: Column(
              children: const [
                Text(
                    "Terms and Conditions for Barterlt Application \n\nBy using Barterlt Application, you agree to the following : \n\n1) Eligibility: You must be 15 years or older to use the application. \n2) License: You are granted a limited, non-transferable license to use the application for personal use. \n3) User Responsibilities: Use the application responsibly and comply with applicable laws. \n4) Privacy: We value your privacy. Refer to our privacy policy for details. \n5) Intellectual Property: Respect our intellectual property rights and do not use them without permission. \n6) Limitation of Liability: We are not responsible for any damages or losses from using the application. \n7) Termination: We can terminate or suspend your access to the application at any time. \n8) Modifications: We may update these terms. Any changes will be notified within the application."),
                // Add your terms and conditions text or widget here
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
