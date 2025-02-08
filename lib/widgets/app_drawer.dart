import 'package:flutter/material.dart';
import 'package:living_smile_app/screens/home_page.dart';
import 'package:living_smile_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:living_smile_app/screens/donation_education_materials.dart';
import 'package:living_smile_app/screens/donation_health_insurance.dart';
import 'package:living_smile_app/screens/donation_skill_smile_centre.dart';
import 'package:living_smile_app/screens/registration_page_donor.dart';
import 'package:living_smile_app/screens/registration_page_member.dart';
import '../screens/about_page.dart';
import '../screens/payments_page.dart';
import '../screens/contact_page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _isLoggedIn = false;
  String? _userEmail;
  String? _userRole;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from SharedPreferences
  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getString('userId') != null;
      _userEmail = prefs.getString('userEmail');
      _userRole = prefs.getString('userRole');
    });
  }

  // Logout function to clear user data and redirect to login page
  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      _isLoggedIn = false;
      _userEmail = null;
      _userRole = null;
    });
    Navigator.pushReplacementNamed(context, LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFDFDFA), // Off-white
              Color(0xFFF1B557), // Yellow
              Color(0xFF4392BB), // Primary blue
              Color(0xFF223B6A), // Dark blue
            ],
            stops: [0.0, 0.33, 0.66, 1.0],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildDrawerHeader(),
            _buildListTile(
                context, Icons.home, 'Home', HomePage.routeName),
            _buildListTile(
                context, Icons.info, 'About Us', AboutPage.routeName),
            _buildExpansionTile(
              context,
              Icons.event,
              'Our Programs',
              [
                _buildSubItem(
                    context, 'Charity Organisation', Icons.people, '/charity'),
                _buildSubItem(context, 'Sports and Games Bonanza',
                    Icons.sports_soccer, '/sports'),
                _buildSubItem(
                    context, 'Debate Clubs Championship', Icons.mic, '/debate'),
              ],
            ),
            _buildExpansionTile(
              context,
              Icons.monetization_on,
              'Donation Window',
              [
                _buildSubItem(context, 'Health Insurance', Icons.local_hospital,
                    DonationHealthInsurancePage.routeName),
                _buildSubItem(context, 'Educational Materials', Icons.school,
                    DonationEducationMaterialsPage.routeName),
                _buildSubItem(context, 'Skills Smile Centre', Icons.face,
                    DonationSkillSmileCentrePage.routeName),
              ],
            ),
            _buildListTile(
                context, Icons.payment, 'Payments', PaymentsPage.routeName),
            _buildListTile(context, Icons.contact_mail, 'Contact Us',
                ContactPage.routeName),
            // Display registration options only if the user is not logged in
            if (!_isLoggedIn) ...[
              _buildExpansionTile(
                context,
                Icons.person_add,
                'Registration',
                [
                  _buildSubItem(context, 'Register as a Member',
                      Icons.group_add, RegistrationPageMember.routeName),
                  _buildSubItem(context, 'Register as a Donor',
                      Icons.card_giftcard, RegistrationPageDonor.routeName),
                ],
              ),
              _buildListTile(
                  context, Icons.login, 'Login', LoginPage.routeName),
            ],
            // Show logout item only if the user is logged in
            if (_isLoggedIn) ...[
              _buildListTile(
                context,
                Icons.logout,
                'Logout',
                '',
                onTap: _logout, // Logout action
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF1B557), // Yellow
            Color(0xFF4392BB), // Primary blue
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: _isLoggedIn ? _buildLoggedInHeader() : _buildLoggedOutHeader(),
    );
  }

  Widget _buildLoggedInHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            _userEmail != null ? _userEmail![0].toUpperCase() : '?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF223B6A),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          _userEmail ?? 'Guest',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          _userEmail ?? 'No email available',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        Text(
          _userRole ?? '',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // Logged-out drawer header
  Widget _buildLoggedOutHeader() {
    return Center(
      child: Text(
        'Please Log In',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListTile(
      BuildContext context, IconData icon, String title, String route,
      {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.indigo,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap ?? () => Navigator.pushNamed(context, route),
    );
  }

  Widget _buildExpansionTile(BuildContext context, IconData icon, String title,
      List<Widget> children) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconColor: Colors.white,
        childrenPadding: EdgeInsets.only(left: 20),
        children: children,
      ),
    );
  }

  Widget _buildSubItem(
      BuildContext context, String title, IconData icon, String route) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFFFDFDFA)), // Off-white for sub-items
      title: Text(
        title,
        style: TextStyle(
          color: Colors.indigo,
          fontSize: 16,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}
