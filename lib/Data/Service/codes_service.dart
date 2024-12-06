import 'package:cloud_firestore/cloud_firestore.dart';

class CodeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Compara uma string com o campo "code" na coleção "code_created" no Firestore.
  ///
  /// [codeToCompare] é a string que será comparada.
  /// Retorna `true` se o código for encontrado e for igual, `false` caso contrário.
  Future<bool> isCodeEqual(String codeToCompare) async {
    try {
      // Consulta todos os documentos na coleção "code_created"
      final querySnapshot = await _firestore.collection('created_codes').get();

      for (final doc in querySnapshot.docs) {
        final String code = doc['code'] ?? '';
        if (code == codeToCompare) {
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Erro ao verificar o código: $e');
      return false;
    }
  }
}