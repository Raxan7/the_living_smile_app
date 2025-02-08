import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const String routeName = '/about';

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF4392BB), // Primary Blue
                Color(0xFF223B6A), // Dark Blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      // Use off-white as the background
      body: Container(
        color: Color(0xFFFDFDFA), // Off-white
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'lib/assets/images/lsi_logo.jpeg',
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              _buildSection(
                icon: Icons.history,
                title: 'History',
                content:
                    'The Living Smile International is the Non governmental organization with the registration number ooNGO/R/5698 under the Ministry of Community Development, Gender, Women and Special Groups.',
              ),
              _buildSection(
                icon: Icons.visibility,
                title: 'Vision',
                content:
                    'To be a centre of excellence that conducts cutting edge research, training, workshops, and capacity building on education, parenting, marriage, family, environment and human development for better.',
              ),
              _buildSection(
                icon: Icons.flag,
                title: 'Mission',
                content:
                    'To support and be promoters in providing service of inclusive and quality education, climate action, nurturing, care and develop human potentials, strengthen families, fulfilled couples and psychologically healthy individuals.',
              ),
              _buildSection(
                icon: Icons.thumb_up,
                title: 'Values',
                content:
                    'Integrity, Professionalism, Transparency, Accountability, Teamwork, Innovation, and Community focus.',
              ),
              _buildSection(
                icon: Icons.assignment,
                title: 'Objectives',
                content:
                    'To improve the quality of education, promote environmental conservation, strengthen family units, and enhance human development.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 28,
                  color: Color(0xFF223B6A), // Dark Blue for icon
                ),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF223B6A), // Dark Blue for title
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Color(0xFF4392BB), // Primary Blue for content
              ),
            ),
          ],
        ),
      ),
    );
  }
}
