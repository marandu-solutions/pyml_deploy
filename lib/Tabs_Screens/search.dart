import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];
  bool _isLoading = false;

  void _onSearchChanged(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      setState(() {
        _searchResults = querySnapshot.docs;
      });
    } catch (e) {
      print('Erro durante a busca: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _onSearchChanged(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Barra de Pesquisa
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        // Indicador de carregamento ou lista de resultados
        _isLoading
            ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        )
            : Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final user = _searchResults[index].data() as Map<String, dynamic>;
              return _buildUserCard(user);
            },
          ),
        ),
      ],
    );
  }

  // Widget de card para cada usuário
  Widget _buildUserCard(Map<String, dynamic> user) {
    String name = user['name'] ?? 'Nome não disponível';
    String? photoUrl = user['photoUrl'];

    // Verifique se a URL da foto é um link do Google Drive e formate a URL
    if (photoUrl != null && photoUrl.contains('drive.google.com')) {
      photoUrl = _getGoogleDriveImageUrl(photoUrl);
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Foto do usuário (ou padrão)
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: photoUrl != null
                  ? Image.network(
                photoUrl,
                width: 48.0,
                height: 64.0, // Tamanho 3x4 (aproximado)
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              )
                  : Image.asset(
                'assets/default_user.png', // Foto padrão
                width: 48.0,
                height: 64.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            // Nome do usuário
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para converter o link do Google Drive para link direto de imagem
  String _getGoogleDriveImageUrl(String photoUrl) {
    final fileId = photoUrl.split('/d/')[1].split('/')[0];
    return 'https://drive.google.com/uc?id=$fileId';
  }
}
