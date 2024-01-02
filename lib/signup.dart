import 'package:flutter/material.dart';
import 'package:fluttertest/login.dart';
import 'package:fluttertest/main.dart';


void main() {
  runApp(SignUp());
}

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SignUp Page",
      home: SignUpPage(),

    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();

}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'First Name',hintText: "enter first name"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _lastNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Last Name',hintText: "enter last name"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Email',hintText: "enter an email"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _mobileController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Mobile',hintText: "enter mobilenumber"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: "enter password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  _signUp();
                },
                child: Text('Sign Up'),
              ),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
              }, child: Text("already have an account?"))
            ],
          ),
        ),
      ),
    );
  }


  void _signUp() {
    if (_formKey.currentState?.validate() ?? false) {
      // signup logic
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      String email = _emailController.text;
      String mobile = _mobileController.text;
      String password = _passwordController.text;

      //signup logic
      print('First Name: $firstName, Last Name: $lastName, Email: $email, Mobile: $mobile, Password: $password');

      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(name: _firstNameController.text,)),);
    }
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