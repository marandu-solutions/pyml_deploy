import 'package:flutter/material.dart';

import '../HTML/interpreter/html_interpreter.dart';

class CodeListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HtmlEditor()),
              );
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 200, // Altura do card
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Bordas arredondadas
              child: Image.asset(
                'assets/code_cards/card${index + 1}.png',
                fit: BoxFit.fill, // Imagem cobre o card inteiro
              ),
            ),
          ),
        );
      },
    );
  }
}