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
}
