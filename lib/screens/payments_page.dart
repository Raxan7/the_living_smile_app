import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/constants.dart';

class PaymentsPage extends StatelessWidget {
  static const String routeName = '/payments';

  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with a gradient background
      appBar: AppBar(
        title: Text(
          'Payments Modalities',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
      backgroundColor: Color(0xFFFDFDFA), // Off-white background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Large Payment Icon
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
                Icons.account_balance_wallet_rounded,
                size: 60,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),

            // Page Header
            Text(
              'Payment Options',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF223B6A), // Dark Blue
              ),
            ),
            SizedBox(height: 20),

            // Payment Option Cards
            _buildPaymentOption(context, 'Vodacom: ${AppConstants.vodacomNumber}', AppConstants.vodacomNumber),
            _buildPaymentOption(context, 'Exim Bank: ${AppConstants.eximBankAccount}', AppConstants.eximBankAccount),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(BuildContext context, String optionText, String valueToCopy) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Color(0xFF4392BB), width: 1),
      ),
      child: ListTile(
        title: Text(
          optionText,
          style: TextStyle(fontSize: 18, color: Color(0xFF223B6A)),
        ),
        trailing: Icon(Icons.copy, color: Color(0xFFF1B557)), // Yellow accent
        onTap: () {
          Clipboard.setData(ClipboardData(text: valueToCopy));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Copied to clipboard',
                style: TextStyle(color: Colors.white),
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Color(0xFF4392BB), // Primary Blue
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4.0,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1,
                left: 20,
                right: 20,
              ),
            ),
          );
        },
      ),
    );
  }
}
