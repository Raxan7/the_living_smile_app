import 'package:flutter/material.dart';

class ProgramsPage extends StatelessWidget {
  static const String routeName = '/programs';

  const ProgramsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Programs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Our Programs',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildProgramItem('Charity Organisation'),
            _buildProgramItem('Sports and Games Bonanza'),
            _buildProgramItem('Debate Clubs Championship'),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramItem(String programName) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          programName,
          style: TextStyle(fontSize: 18),
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Add navigation or functionality here
        },
      ),
    );
  }
}