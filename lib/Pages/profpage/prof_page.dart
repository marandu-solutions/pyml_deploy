import 'package:flutter/material.dart';

class ProfessorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página do Professor'),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Text(
          'Bem-vindo à página do Professor!',
          style: TextStyle(fontSize: 24, color: Colors.blue[800]),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
