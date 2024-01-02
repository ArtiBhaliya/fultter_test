import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertest/main.dart';
import 'dart:convert';

class EmployeeDetailsScreen extends StatelessWidget {
  final int employeeId;

  EmployeeDetailsScreen({required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder(
        future: fetchEmployeeDetails(employeeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var employee = snapshot.data;

            if (employee != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${employee['data']['employee_name'] ?? 'N/A'}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  Text('Salary: ${employee['data']['employee_salary'] ?? 'N/A'}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  Text('Age: ${employee['data']['employee_age'] ?? 'N/A'}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                ],
              );
            }
          }
          return Text("data");
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchEmployeeDetails(int employeeId) async {
    final response = await http.get(
        Uri.parse('https://dummy.restapiexample.com/api/v1/employee/$employeeId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load employee details');
    }
  }
}

class Employee {
  final int id;
  final String employeeName;
  final int employeeSalary;
  final int employeeAge;
  final String profileImage;

  Employee({
    required this.id,
    required this.employeeName,
    required this.employeeSalary,
    required this.employeeAge,
    required this.profileImage,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      employeeName: json['employee_name'],
      employeeSalary: json['employee_salary'],
      employeeAge: json['employee_age'],
      profileImage: json['profile_image'],
    );
  }
}
class ApiResponse {
  final String status;
  final List<Employee> data;
  final String message;

  ApiResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      data: List<Employee>.from(
          json['data'].map((employee) => Employee.fromJson(employee))),
      message: json['message'],
    );
  }
}