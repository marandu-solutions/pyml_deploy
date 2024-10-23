// This is a basic Flutter widget test.
//
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicas de Python',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PythonTipsScreen(),
    );
  }
}

class PythonTipsScreen extends StatelessWidget {
  final List<String> tips = [
    "1. Use listas por compreensão para uma sintaxe mais clara.",
    "2. Utilize o método .join() para unir strings.",
    "3. A função zip() pode combinar duas listas.",
    "4. Aproveite a f-string para formatação de strings.",
    "5. Use 'with' para gerenciamento automático de recursos.",
    "6. Explore bibliotecas como NumPy e Pandas para ciência de dados.",
    "7. Aprenda sobre decorators para modificar funções.",
    "8. Utilize os módulos para organizar seu código."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dicas de Python'),
        backgroundColor: Colors.blue[900], // Azul escuro
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Ação da pesquisa (pode implementar depois)
              showSearch(
                context: context,
                delegate: SearchDelegateExample(),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.blue[900], // Fundo azul escuro
      body: ListView.builder(
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white, // Fundo do card
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  tips[index],
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchDelegateExample extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Limpa a pesquisa
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // Aqui você pode implementar a lógica de resultados
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // Aqui você pode implementar sugestões de pesquisa
  }
}

