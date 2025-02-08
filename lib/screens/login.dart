import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:living_smile_app/screens/home_page.dart';
import 'package:living_smile_app/screens/registration_page.dart';
import 'package:living_smile_app/screens/registration_page_donor.dart';
import 'package:living_smile_app/screens/registration_page_member.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  // For animated background on the card
  int _currentGradientIndex = 0;
  Timer? _timer;
  final List<Gradient> gradients = [
    // Subtle gradients using your dominant colors with 10% opacity overlay on the off-white base.
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
    // Change gradient every 3 seconds with smooth animation
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

  Widget _buildTextField(String hint, IconData icon, TextEditingController controller, bool isPassword) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? _isObscure : false,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Color.fromRGBO(67, 146, 187, 1)),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hint cannot be empty";
        }
        if (isPassword && value.length < 6) {
          return "Enter at least 6 characters";
        }
        return null;
      },
      keyboardType: hint == "Email" ? TextInputType.emailAddress : TextInputType.text,
    );
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        
        // Get the user from Firestore to retrieve their role
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')  // Replace with your Firestore collection name
            .doc(userCredential.user!.uid)
            .get();
        
        if (userDoc.exists) {
          String userRole = userDoc['role'];  // Assuming the field is named 'role'
          
          // Save the user data and role in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userEmail', userCredential.user!.email!);
          await prefs.setString('userId', userCredential.user!.uid);
          await prefs.setString('userRole', userRole);  // Save role here
          
          // Navigate to the correct screen based on the role
          if (userRole == 'Donor') {
            // Redirect to the Donor page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (userRole == 'Member') {
            // Redirect to the Member page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        } else {
          _showError("No role found for this user");
        }
      } on FirebaseAuthException catch (e) {
        _showError(e.message ?? "Login failed");
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }



  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showRegistrationDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow dismissing by tapping outside
      builder: (BuildContext context) {
        return GlassCard(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Register as',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(34, 59, 106, 1), // Dark Blue
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildRegisterButton("Donor", Color.fromRGBO(67, 146, 187, 1), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPageDonor()),
                  );
                }),
                SizedBox(height: 12),
                _buildRegisterButton("Member", Color.fromRGBO(241, 181, 87, 1), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPageMember()),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper method to create styled buttons
  Widget _buildRegisterButton(String label, Color color, Function onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 253, 250, 1),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header: Logo and Welcome Text
              Image.asset(
                'lib/assets/images/lsi_logo.jpeg',
                height: 120,
              ),
              SizedBox(height: 30),
              Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(34, 59, 106, 1),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Login to your account",
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              SizedBox(height: 30),
              // Animated Form Card
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
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField("Email", Icons.email, emailController, false),
                      SizedBox(height: 20),
                      _buildTextField("Password", Icons.lock, passwordController, true),
                      SizedBox(height: 30),
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : () => _signIn(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(67, 146, 187, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  "Login",
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Register Navigation
                      TextButton(
                        onPressed: _showRegistrationDialog,
                        child: Text(
                          "Don't have an account? Register Now",
                          style: TextStyle(
                            color: Color.fromRGBO(34, 24, 9, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom GlassCard Widget to achieve the glass/mirror effect
class GlassCard extends StatelessWidget {
  final Widget child;

  const GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(20), // Padding for the content inside the card
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.3), // Light mirrored border
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            // Apply a blur effect in the background
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: Container(
                  color: Colors.black.withOpacity(0.1), // Frosted effect
                ),
              ),
            ),
            // The actual content of the card
            child,
          ],
        ),
      ),
    );
  }
}