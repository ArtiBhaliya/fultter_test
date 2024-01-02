import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

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



class EmployeeDetailsScreen extends StatelessWidget {
  final int employeeId;

  EmployeeDetailsScreen({required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
      ),
      body: FutureBuilder(
        // Implement API call to get employee details
        future: fetchEmployeeDetails(employeeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var employee = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${employee?['employee_name'] ?? 'N/A'}'),
                Text('Salary: ${employee?['employee_salary'] ?? 'N/A'}'),
                Text('Age: ${employee?['employee_age'] ?? 'N/A'}'),
              ],
            );
          }
        },
      ),
    );
  }
  Future<Map<String, dynamic>> fetchEmployeeDetails(int employeeId) async {
    final response = await http.get(Uri.parse('https://dummy.restapiexample.com/api/v1/e'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load employee details');
    }
  }
}