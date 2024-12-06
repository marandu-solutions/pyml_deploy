import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final bool isSuccess;

  SuccessScreen({required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.cancel,
              color: isSuccess ? Colors.green : Colors.red,
              size: 100,
            ),
            SizedBox(height: 20), // Espaçamento entre o ícone e o texto
            Text(
              isSuccess
                  ? 'Parabéns!!! seu código estava perfeito!'
                  : 'Tente novamente, seu código possuía erros.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}