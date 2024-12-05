import 'package:cloud_firestore/cloud_firestore.dart';

class CreatedCodesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Adiciona um novo código à coleção `created_codes`.
  ///
  /// - [code]: Código a ser adicionado (string).
  /// - [userId]: ID do usuário que criou o código (string).
  Future<void> addCreatedCode({required String code, required String userId}) async {
    try {
      // Referência ao documento do usuário na coleção `users`.
      DocumentReference userRef = _firestore.collection('users').doc(userId);

      await _firestore.collection('created_codes').add({
        'code': code,
        'user': userRef,
      });

      print('Código adicionado com sucesso.');
    } catch (e) {
      print('Erro ao adicionar código: $e');
      rethrow;
    }
  }

  /// Recupera todos os códigos criados por um usuário específico.
  ///
  /// - [userId]: ID do usuário.
  /// Retorna uma lista de mapas contendo os códigos.
  Future<List<Map<String, dynamic>>> getCreatedCodesByUser(String userId) async {
    try {
      // Referência ao documento do usuário na coleção `users`.
      DocumentReference userRef = _firestore.collection('users').doc(userId);

      QuerySnapshot querySnapshot = await _firestore
          .collection('created_codes')
          .where('user', isEqualTo: userRef)
          .get();

      // Mapeia os documentos para uma lista de mapas.
      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Erro ao buscar códigos: $e');
      rethrow;
    }
  }
}
