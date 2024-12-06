import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:pyml/Providers/user_provider.dart';

class UserDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Verifica se o userId existe
    if (userProvider.userId == null) {
      return Center(
        child: Text('Usuário não encontrado'),
      );
    }

    // Buscar dados do usuário no Firebase Firestore
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(userProvider.userId)
          .get(), // Obtém o documento do usuário
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar dados'));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('Usuário não encontrado'));
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>;
        String name = userData['name'] ?? 'Nome não disponível';
        String? photoUrl = userData['photoUrl'];

        // Verifique se a URL da foto é um link do Google Drive e formate a URL
        if (photoUrl != null && photoUrl.contains('drive.google.com')) {
          photoUrl = _getGoogleDriveImageUrl(photoUrl);
        }

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                children: [
                  // Foto do usuário com ClipOval
                  Center(
                    child: ClipOval(
                      child: photoUrl != null
                          ? Image.network(
                        photoUrl,
                        width: 300.0,
                        height: 300.0,
                        fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                      )
                          : Image.asset(
                        'assets/default_user.png', // Foto padrão
                        width: 120.0,
                        height: 120.0,
                        fit: BoxFit.cover, // Garantir que a imagem cubra o círculo
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Nome do usuário
                  Center(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Card com informações adicionais
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 200, // Altura do "card"
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '0', // Substitua por dados reais se necessário
                          style: TextStyle(
                            fontSize: 48.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'CÓDIGOS CRIADOS',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Botão de Logout com fundo branco
            Padding(
              padding: const EdgeInsets.only(bottom: 82.0),
              child: Container(
                color: Colors.white, // Fundo branco do botão
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Texto de Logout
                    GestureDetector(
                      onTap: () {
                        userProvider.logout();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text(
                        'Sair',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    // Ícone de Logout
                    GestureDetector(
                      onTap: () {
                        userProvider.logout();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Função para converter o link do Google Drive para link direto de imagem
  String _getGoogleDriveImageUrl(String photoUrl) {
    final fileId = photoUrl.split('/d/')[1].split('/')[0];
    return 'https://drive.google.com/uc?id=$fileId';
  }
}
