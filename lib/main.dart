import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:living_smile_app/firebase_options.dart';
import 'package:living_smile_app/screens/charity_organisation_page.dart';
import 'package:living_smile_app/screens/debate_clubs_page.dart';
import 'package:living_smile_app/screens/donation_education_materials.dart';
import 'package:living_smile_app/screens/donation_health_insurance.dart';
import 'package:living_smile_app/screens/donation_skill_smile_centre.dart';
import 'package:living_smile_app/screens/home_page.dart';
import 'package:living_smile_app/screens/login.dart';
import 'package:living_smile_app/screens/registration_page_donor.dart';
import 'package:living_smile_app/screens/registration_page_member.dart';
import 'package:living_smile_app/screens/sports_games_page.dart';
import 'screens/about_page.dart';
import 'screens/programs_page.dart';
import 'screens/donation_page.dart';
import 'screens/registration_page.dart';
import 'screens/payments_page.dart';
import 'screens/contact_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Living Smile International',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        HomePage.routeName: (context) => HomePage(),
        AboutPage.routeName: (context) => AboutPage(),
        ProgramsPage.routeName: (context) => ProgramsPage(),
        DonationPage.routeName: (context) => DonationPage(),
        DonationHealthInsurancePage.routeName: (context) => DonationHealthInsurancePage(),
        DonationEducationMaterialsPage.routeName: (context) => DonationEducationMaterialsPage(),
        DonationSkillSmileCentrePage.routeName: (context) => DonationSkillSmileCentrePage(),
        RegistrationPage.routeName: (context) => RegistrationPage(),
        RegistrationPageDonor.routeName: (context) => RegistrationPageDonor(),
        RegistrationPageMember.routeName: (context) => RegistrationPageMember(),
        LoginPage.routeName: (context) => LoginPage(),
        PaymentsPage.routeName: (context) => PaymentsPage(),
        ContactPage.routeName: (context) => ContactPage(),
        CharityOrganisationPage.routeName: (context) => CharityOrganisationPage(),
        SportsGamesPage.routeName: (context) => SportsGamesPage(),
        DebateClubsPage.routeName: (context) => DebateClubsPage(),
      },
    );
  }
}
