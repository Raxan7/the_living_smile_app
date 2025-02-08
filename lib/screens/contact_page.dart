import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  static const String routeName = '/contact';

  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient AppBar
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
      backgroundColor: Color(0xFFFDFDFA), // Off-white background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Large Contact Icon
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF4392BB), // Primary Blue
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.support_agent_rounded,
                size: 60,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),

            // Page Title
            Text(
              'Get in Touch',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF223B6A), // Dark Blue
              ),
            ),
            SizedBox(height: 20),

            // Contact Information Cards
            _buildContactItem(context, Icons.phone, '0656498772', Colors.green),
            _buildContactItem(context, Icons.phone, '0622020301', Colors.green),
            _buildContactItem(context, Icons.email, 'info@lsi.or.tz', Colors.red),
            _buildContactItem(context, Icons.language, 'www.lsi.or.tz', Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(BuildContext context, IconData icon, String text, Color iconColor) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Color(0xFF4392BB), width: 1),
      ),
      child: ListTile(
        leading: Icon(icon, size: 40, color: iconColor),
        title: Text(
          text,
          style: TextStyle(fontSize: 18, color: Color(0xFF223B6A)),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFFF1B557)), // Yellow accent
        onTap: () async {
          String? url;
          if (icon == Icons.phone) {
            url = 'tel:$text';
          } else if (icon == Icons.email) {
            url = 'mailto:$text';
          } else if (icon == Icons.language) {
            url = 'https://$text';
          }

          if (url != null && await canLaunch(url)) {
            await launch(url);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Could not launch $url'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
