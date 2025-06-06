import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final TextEditingController _firstNameController  = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final prefs =  EncryptedSharedPreferences();

  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String emailAddress = '';

  @override
  void initState() {
    super.initState();
    loadData();

    _firstNameController.addListener(() {fieldChange('firstName');});
    _lastNameController.addListener(() {fieldChange('lastName');});
    _phoneNumberController.addListener(() {fieldChange('phone');});
    _emailAddressController.addListener(() {fieldChange('email');});
  }

  void fieldChange(String field) {
    switch (field) {
      case 'firstName':
        firstName = _firstNameController.text;
        break;
      case 'lastName':
        lastName = _lastNameController.text;
        break;
      case 'phone':
        phoneNumber = _phoneNumberController.text;
        break;
      case 'email':
        emailAddress = _emailAddressController.text;
        break;
    }
    saveData();
  }

  Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showAlertDialog('URL is not supported on this device.');
    }
  }

  void showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future loadData() async {
    try {
      _firstNameController.text = firstName = await prefs.getString('firstName') ?? '';
      _lastNameController.text = lastName = await prefs.getString('lastName') ?? '';
      _phoneNumberController.text = phoneNumber = await prefs.getString('phoneNumber') ?? '';
      _emailAddressController.text = emailAddress = await prefs.getString('emailAddress') ?? '';
    } catch (e) {
      print('Error loading data from EncryptedSharedPreferences: $e');
    }
  }

  Future saveData() async {
    try {
      await prefs.setString('firstName', firstName);
      await prefs.setString('lastName', lastName);
      await prefs.setString('phoneNumber', phoneNumber);
      await prefs.setString('emailAddress', emailAddress);
    } catch (e) {
      print('Error saving data to EncryptedSharedPreferences: $e');
    }
  }

  final ButtonStyle iconStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      fixedSize: const Size(50, 50)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Page")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back, ${DataRepository.loginName}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  border: Border.all(
                    // color: Colors.grey,
                    width: 1.0,
                  )
              ),
              child: TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  border: Border.all(
                    // color: Colors.grey,
                    width: 1.0,
                  )
              ),
              child: TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     color: Colors.grey,
              //     width: 1.0,
              //   )
              // ),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        border: OutlineInputBorder()
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () => launchURL('tel:${_phoneNumberController.text}'),
                      style: iconStyle,
                      child: const Icon(
                        Icons.call,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => launchURL('sms:${_phoneNumberController.text}'),
                    style: iconStyle,
                    child: const Icon(
                      Icons.message,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              // decoration: BoxDecoration(
              //     border: Border.all(
              //       color: Colors.grey,
              //       width: 1.0,
              //     )
              // ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: TextField(
                      controller: _emailAddressController,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => launchURL('mailto:${_emailAddressController.text}'),
                    style: iconStyle,
                    child: const Icon(
                      Icons.email,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  
  
}