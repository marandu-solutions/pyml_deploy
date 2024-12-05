import 'package:flutter/material.dart';

class CardsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 200, // Altura do card
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10), // Bordas arredondadas
            child: Image.asset(
              'assets/cards/card${index + 1}.png',
              fit: BoxFit.fill, // Imagem cobre o card inteiro
            ),
          ),
        );
      },
    );
  }
}