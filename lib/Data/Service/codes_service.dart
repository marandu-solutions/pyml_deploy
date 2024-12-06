import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class CodeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Compara uma string com o campo "code" na coleção "code_created" no Firestore.
  ///
  /// [codeToCompare] é a string que será comparada.
  /// Retorna `true` se o código for encontrado e for igual, `false` caso contrário.
  Future<bool> isCodeEqual(String codeToCompare) async {
    String code1 = '''<html> 
    <head> 
        <title>Exemplo do atributo href</title> 
    </head> 
    <body> 
        <h1>Exemplo do atributo href</h1> 
        <p> 
            <a href="https://www.freecodecamp.org/contribute/">A página de contribuição do freeCodeCamp</a> 
            mostra para você como e onde você pode contribuir com a comunidade e com o crescimento do freeCodeCamp. 
        </p> 
    </body> 
</html>''';

    try {
      // Consulta todos os documentos na coleção "code_created"
      final querySnapshot = await _firestore.collection('created_codes').get();

      for (final doc in querySnapshot.docs) {
        final String code = doc['code'] ?? '';
        if (codeToCompare == code1 ) {
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