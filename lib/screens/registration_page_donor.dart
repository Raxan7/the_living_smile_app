import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:living_smile_app/screens/login.dart';

class RegistrationPageDonor extends StatefulWidget {
  static const String routeName = '/registration-donor';

  const RegistrationPageDonor({super.key});
  
  @override
  _RegistrationPageDonorState createState() => _RegistrationPageDonorState();
}

class _RegistrationPageDonorState extends State<RegistrationPageDonor> {
  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  // Controllers for form fields
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;

  // For animated background on the card
  int _currentGradientIndex = 0;
  Timer? _timer;
  final List<Gradient> gradients = [
    // Faint gradients: base color is the light off-white, overlaid with a very transparent accent color.
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(253, 253, 250, 1),
        Color.fromRGBO(253, 253, 250, 0.1),
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(253, 253, 250, 1),
        Color.fromRGBO(241, 181, 87, 0.1),
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(253, 253, 250, 1),
        Color.fromRGBO(67, 146, 187, 0.1),
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(253, 253, 250, 1),
        Color.fromRGBO(34, 59, 106, 0.1),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Update the gradient index every 3 seconds
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _currentGradientIndex = (_currentGradientIndex + 1) % gradients.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 253, 250, 1), // Off-white background
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Header Section (Logo and Title)
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/images/lsi_logo.jpeg',
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Donor Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(34, 59, 106, 1), // Dark blue text
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Animated Registration Form Card
            AnimatedContainer(
              duration: Duration(seconds: 2),
              curve: Curves.easeInOut,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: gradients[_currentGradientIndex],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    // Full Name Field
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        labelStyle: TextStyle(color: Color.fromRGBO(34, 59, 106, 1)),
                        prefixIcon: Icon(Icons.person, color: Color.fromRGBO(67, 146, 187, 1)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // Email Field
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Color.fromRGBO(34, 59, 106, 1)),
                        prefixIcon: Icon(Icons.email, color: Color.fromRGBO(67, 146, 187, 1)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email cannot be empty";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\\.[a-z]+").hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                    // Mobile Field
                    TextFormField(
                      controller: mobileController,
                      decoration: InputDecoration(
                        labelText: "Mobile Number",
                        labelStyle: TextStyle(color: Color.fromRGBO(34, 59, 106, 1)),
                        prefixIcon: Icon(Icons.phone, color: Color.fromRGBO(67, 146, 187, 1)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Mobile number cannot be empty";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 20),
                    // Password Field
                    TextFormField(
                      controller: passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Color.fromRGBO(34, 59, 106, 1)),
                        prefixIcon: Icon(Icons.lock, color: Color.fromRGBO(67, 146, 187, 1)),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty";
                        }
                        if (value.length < 6) {
                          return "Please enter a valid password (min. 6 characters)";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // Confirm Password Field
                    TextFormField(
                      controller: confirmpassController,
                      obscureText: _isObscure2,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(color: Color.fromRGBO(34, 59, 106, 1)),
                        prefixIcon: Icon(Icons.lock, color: Color.fromRGBO(67, 146, 187, 1)),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure2 ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure2 = !_isObscure2;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      ),
                      validator: (value) {
                        if (confirmpassController.text != passwordController.text) {
                          return "Password did not match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    // Action Buttons: Login and Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(67, 146, 187, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showProgress = true;
                            });
                            signUp(emailController.text, passwordController.text, "Donor");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(241, 181, 87, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void signUp(String email, String password, String role) async {
    // Dummy CircularProgressIndicator call; replace with your own loader if needed.
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => postDetailsToFirestore(email, role))
            .catchError((e) {});
      } catch (e) {
        // Optionally handle error here
      }
    }
  }

  postDetailsToFirestore(String email, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    // Save additional details like name and mobile into Firestore
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({
      'email': emailController.text,
      'role': role,
      'name': nameController.text,
      'mobile': mobileController.text
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
