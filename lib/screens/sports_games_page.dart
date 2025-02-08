import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:living_smile_app/screens/donation_skill_smile_centre.dart';

class SportsGamesPage extends StatelessWidget {
  static const String routeName = '/sports';

  const SportsGamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sports and Games Bonanza',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(34, 59, 106, 1), // Navy Blue
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Sports Icon
            const Icon(
              Icons.sports,
              size: 80,
              color: Color.fromRGBO(241, 181, 87, 1), // Golden Yellow
            ),

            const SizedBox(height: 20),

            // Sports Image Carousel (using only one image, sports1.jpg)
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: [
                'sports1.jpg',
              ].map((fileName) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'lib/assets/images/$fileName',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Content Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About the Sports Bonanza',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(34, 59, 106, 1), // Navy Blue
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Our Sports and Games Bonanza is designed to promote physical fitness, teamwork, and community spirit. '
                    'We organize annual events that bring together participants of all ages to compete in various sports and games.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Key Features:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(34, 59, 106, 1), // Navy Blue
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildFeature('Football Tournaments', Icons.sports_soccer),
                  _buildFeature('Athletics Competitions', Icons.directions_run),
                  _buildFeature('Community Games', Icons.people),

                  const SizedBox(height: 20),

                  // Participate Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DonationSkillSmileCentrePage()), // Target page
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        backgroundColor: const Color.fromRGBO(241, 181, 87, 1), // Golden Yellow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Support'),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Feature Card UI
  Widget _buildFeature(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 28,
            color: const Color.fromRGBO(67, 146, 187, 1), // Sky Blue
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
