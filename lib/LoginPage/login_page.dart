import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue, // Cor de fundo azul
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo no topo
                Image.asset(
                  'assets/img.png', // Certifique-se de ter uma imagem chamada 'img.png' na pasta 'assets'
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 30),
                // Campo de login
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Login',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                // Campo de senha
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                // Botão de login
                ElevatedButton(
                  onPressed: () {
                    // Adicione a lógica de login aqui
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan, // Cor de fundo do botão
                    foregroundColor: Colors.white, // Cor do texto do botão
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
