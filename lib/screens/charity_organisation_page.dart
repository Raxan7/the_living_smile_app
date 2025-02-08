import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:living_smile_app/screens/donation_health_insurance.dart';

class CharityOrganisationPage extends StatelessWidget {
  static const String routeName = '/charity';

  const CharityOrganisationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Charity Organisation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(34, 59, 106, 1), // Navy Blue
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Charity Icon
            const Icon(
              Icons.volunteer_activism,
              size: 80,
              color: Color.fromRGBO(241, 181, 87, 1), // Golden Yellow
            ),

            const SizedBox(height: 20),

            // Charity Image Carousel
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
                'charity1.jpg',
                'charity2.jpg',
                'charity3.jpg',
                'charity4.jpg'
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

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Our Charity Work',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(34, 59, 106, 1), // Navy Blue
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'The Living Smile International is committed to supporting vulnerable communities through various charity initiatives. '
                    'Our programs focus on providing essential resources such as food, clothing, and medical supplies to those in need.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Our Initiatives',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(34, 59, 106, 1), // Navy Blue
                    ),
                  ),

                  const SizedBox(height: 10),

                  _buildFeatureCard('Food Drives', Icons.fastfood, 'We distribute food packages to underprivileged communities.'),
                  _buildFeatureCard('Medical Camps', Icons.medical_services, 'Free health checkups and medical assistance.'),
                  _buildFeatureCard('Clothing Donations', Icons.shopping_bag, 'Providing clothes and necessities to the needy.'),

                  const SizedBox(height: 20),

                  // Get Involved Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Replace this with the actual page you want to navigate to
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DonationHealthInsurancePage()), // Target page
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        backgroundColor: const Color.fromRGBO(241, 181, 87, 1), // Golden Yellow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Get Involved'),
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
  Widget _buildFeatureCard(String title, IconData icon, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color.fromRGBO(67, 146, 187, 1), // Sky Blue
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.grey[700]),
        ),
      ),
    );
  }
}
