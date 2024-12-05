import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Cor de fundo azul
      body: Stack(
        children: [
          // Boneco 1 centralizado à esquerda e maior
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: 0 - 50,
            child: Image.asset(
              'assets/initial_page_assets/boneco1.png', // Caminho da primeira imagem do boneco
              width: 300,
              height: 300,
            ),
          ),

          // Boneco 2 centralizado à direita e maior
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            right: 0 - 50,
            child: Image.asset(
              'assets/initial_page_assets/boneco2.png', // Caminho da segunda imagem do boneco
              width: 300,
              height: 300,
            ),
          ),

          // Quadro no topo e centralizado
          Positioned(
            top: 0 - 20,
            left: MediaQuery.of(context).size.width * 0.20,
            child: Image.asset(
              'assets/initial_page_assets/Quadro.png', // Caminho da imagem do quadro
              width: 300,
              height: 300,
            ),
          ),

          // Janela com bordas arredondadas contendo o conteúdo
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Texto de boas-vindas
                    Text(
                      "Bem-vindo!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    SizedBox(height: 10),

                    // Texto descritivo
                    Text(
                      "Nossa nova plataforma interativa nos permite criar um ambiente inovador de aprendizado em qualquer lugar.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue[900],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Botão "Avançar"
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cadastro');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Avançar",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    // Link de login
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        "Já tem uma conta? Login",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[900],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
