import 'package:flutter/material.dart';
import 'package:fluttertest/homescreen.dart';
import 'package:fluttertest/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ''
          'Flutter Test',
      home: Login(),//firstly call loginscreen
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String name;

  HomeScreen({required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome ${widget.name}',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 60.0,
        backgroundColor: Colors.deepPurple,
      ),
      body: EmployeeList(),
    );
  }
}
//class for employye's details
class EmployeeList extends StatefulWidget {
  @override
  State<EmployeeList> createState() => EmployeeListState();
}

class EmployeeListState extends State<EmployeeList> {
  List<Employee> getList = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse("https://dummy.restapiexample.com/api/v1/employees"));
          //api callin to desplay employee's data on employee list

    if (response.statusCode == 200) {
      final ApiResponse apiResponse =
          ApiResponse.fromJson(json.decode(response.body));
      setState(() {
        getList = apiResponse.data;
      });
    } else {
      throw Exception('Failed to load employee data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          itemCount:getList.length,
          itemBuilder: (BuildContext context, index) {
            int employeeId = index + 1; // Adding 1 for demonstration purposes

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EmployeeDetailsScreen(employeeId: employeeId);//return selected employee's id
                      },
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.black,
                  child: Text(
                    getList[index].employeeName,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            );


          });
  }
}
//class for store api's data in local variable
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

