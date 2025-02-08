import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:living_smile_app/screens/login.dart';
import 'package:living_smile_app/screens/registration_page_donor.dart';
import 'package:living_smile_app/screens/registration_page_member.dart';
import 'package:living_smile_app/screens/about_page.dart'; // Ensure you have this page
import 'package:living_smile_app/widgets/app_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imagePaths = [
    'lib/assets/images/image1.jpeg',
    'lib/assets/images/image2.jpeg',
    'lib/assets/images/image3.jpeg',
    'lib/assets/images/image4.jpeg',
    'lib/assets/images/image5.jpeg',
    'lib/assets/images/image6.jpeg',
  ];

  // Modify this flag based on actual login state
  bool? isLoggedIn = false;
  String? _userEmail;
  String? _userRole;
  late VideoPlayerController _controller;

  // Dominant colors
  final Color colorFFFDFAB = const Color(0xfffffdfab); // [253 253 250]
  final Color colorF1B557 = const Color(0xFFF1B557); // [241 181  87]
  final Color color4392BB = const Color(0xFF4392BB); // [ 67 146 187]
  final Color color223B6A = const Color(0xFF223B6A); // [ 34  59 106]

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('lib/assets/videos/charity_video.mp4');
    _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
      _controller.setLooping(true);
    });
    _loadUserData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getString('userId') != null;
      _userEmail = prefs.getString('userEmail');
      _userRole = prefs.getString('userRole');
    });
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
                _buildRegisterButton("Donor", Color.fromRGBO(67, 146, 187, 1),
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationPageDonor()),
                  );
                }),
                SizedBox(height: 12),
                _buildRegisterButton("Member", Color.fromRGBO(241, 181, 87, 1),
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationPageMember()),
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'The Living Smile International',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors
              .white, // Or a color that contrasts well with the background
          shadows: [
            // Add the shadow here
            Shadow(
              blurRadius: 10.0, // Adjust blur radius
              color: Colors.black.withOpacity(0.7), // Shadow color
              offset: const Offset(2.0, 2.0), // Shadow offset
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 250,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.85,
                        autoPlayInterval: const Duration(seconds: 3),
                      ),
                      items: imagePaths.map((path) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            path,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          colorFFFDFAB.withOpacity(0.4), // Use dominant color
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Welcome to The Living Smile International',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (isLoggedIn!) // Show the button if the user is logged in
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the About page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutPage(), // Ensure you have an AboutPage widget
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorF1B557, // Button color
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Learn More About The Living Smile Organisation',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  if (!isLoggedIn!) // Show buttons if the user is NOT logged in
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          _buildButton(
                            onPressed: _showRegistrationDialog,
                            backgroundColor: colorF1B557,
                            text: "Get Started",
                          ),
                          const SizedBox(height: 16),
                          _buildButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            backgroundColor: Colors.transparent,
                            text: "Login",
                            borderColor: colorFFFDFAB,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required Color backgroundColor,
    required String text,
    Color? borderColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 3,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          side: borderColor != null ? BorderSide(color: borderColor) : null,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(child: Text(text, style: const TextStyle(color: Colors.white))),
        ),
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        color: Colors.white.withOpacity(0.15),
        child: child,
      ),
    );
  }
}
