import 'package:flutter/material.dart';

class DonationEducationMaterialsPage extends StatefulWidget {
  static const String routeName = '/donation_education_materials';

  const DonationEducationMaterialsPage({super.key});

  @override
  _DonationEducationMaterialsPageState createState() =>
      _DonationEducationMaterialsPageState();
}

class _DonationEducationMaterialsPageState
    extends State<DonationEducationMaterialsPage> {
  double donationAmount = 100.00;
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate for Education Materials',
            style: TextStyle(color: Colors.white)),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  'Make a Donation for Education Materials',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF223B6A), // Dark Blue
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Donation Amount',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF223B6A),
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  _buildAmountButton(10.00),
                  _buildAmountButton(25.00),
                  _buildAmountButton(50.00),
                  _buildAmountButton(100.00),
                  _buildAmountButton(250.00),
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Custom Amount',
                        labelStyle: TextStyle(color: Color(0xFF223B6A)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          donationAmount =
                              double.tryParse(value) ?? donationAmount;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Personal Information',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF223B6A),
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name *',
                  labelStyle: TextStyle(color: Color(0xFF223B6A)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your first name'
                    : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: Color(0xFF223B6A)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address *',
                  labelStyle: TextStyle(color: Color(0xFF223B6A)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              Text(
                'Offline Donation Instructions',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF223B6A),
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15),
              _buildBankDetail(
                  'Account Name', 'The Living Smile International (LSI)'),
              _buildBankDetail('Bank Name', 'EXIM'),
              _buildBankDetail('Account Number', '0340003966'),
              _buildBankDetail('Swift Code', 'EXTNTZTZ'),
              _buildBankDetail(
                  'Bank Address', 'P.O BOX 575, Usa River, Arusha-Tanzania'),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String firstName = _firstNameController.text;
                    String lastName = _lastNameController.text;
                    String email = _emailController.text;

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Offline Donation Information'),
                          content: Text(
                              'Thank you, $firstName $lastName, for your generous donation towards education materials. We will contact you shortly.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Color(0xFFF1B557), // Yellow accent
                ),
                child: Text('Make Offline Donation'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountButton(double amount) {
    bool isSelected = donationAmount == amount;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          donationAmount = amount;
        });
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: TextStyle(fontSize: 16),
        backgroundColor: isSelected ? Color(0xFF4392BB) : Colors.white,
        foregroundColor: isSelected ? Colors.white : Color(0xFF223B6A),
        side: isSelected ? null : BorderSide(color: Color(0xFF223B6A)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text('\$${amount.toStringAsFixed(2)}'),
    );
  }

  Widget _buildBankDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Color(0xFF223B6A), // Dark Blue for text
            fontSize: 16,
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
