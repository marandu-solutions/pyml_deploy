import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String? _userId;
  String? _name;
  String? _photoUrl;

  String? get userId => _userId;
  String? get name => _name;
  String? get photoUrl => _photoUrl;

  /// Carrega os dados do usuário armazenados localmente
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    _name = prefs.getString('name');
    _photoUrl = prefs.getString('photoUrl');
    notifyListeners();
  }

  /// Salva os dados do usuário no SharedPreferences
  Future<void> saveUser({required String userId, required String name, String? photoUrl}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('name', name);
    if (photoUrl != null) {
      await prefs.setString('photoUrl', photoUrl);
    } else {
      await prefs.remove('photoUrl');
    }

    _userId = userId;
    _name = name;
    _photoUrl = photoUrl;
    notifyListeners();
  }

  /// Remove os dados do usuário do SharedPreferences (logout)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _userId = null;
    _name = null;
    _photoUrl = null;
    notifyListeners();
  }

  /// Verifica se o usuário está logado
  bool get isLoggedIn => _userId != null;
}
