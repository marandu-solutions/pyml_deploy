import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser({
    required String userId,
    required String name,
    String? photoUrl,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'name': name,
        'userId': userId,
        'photoUrl': photoUrl,
      });
    } catch (e) {
      throw Exception('Erro ao adicionar usuário: $e');
    }
  }

  Future<List<Map<String, dynamic>>> searchUsersByName(String query) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: '${query}z')
          .get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      throw Exception('Erro ao buscar usuários: $e');
    }
  }
}
