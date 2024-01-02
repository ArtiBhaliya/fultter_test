import 'package:flutter/material.dart';
import 'package:fluttertest/login.dart';
import 'package:http/http.dart' as http;

import 'homescreen.dart';
//import 'package:provider/providers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ''
          'Flutter Test',
      home: Login(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
    );
  }
}

class User {
  String firstName;
  String lastName;
  String email;
  String mobile;
  String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.password,
  });
}

class UserData extends ChangeNotifier {
  User? user;

  void setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome $name'),
      ),
      body: EmployeeList(),
    );
  }
}

class EmployeeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: 10, itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EmployeeDetailsScreen(employeeId: index+1,);
          }));
        },
          child: Container(
            height: 50,
            width: 50,
            color: Colors.black,
            child: const Text("${"employee details"}"),
          ),
        ),
      );
    });
  }
}
//https://github.com/ArtiBhaliya/fultter_test