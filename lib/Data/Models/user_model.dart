class User {
  final String name;
  final String userId;
  final String? photoUrl;

  User({
    required this.name,
    required this.userId,
    this.photoUrl,
  });

  // Método para converter um objeto User para Map (ex: salvar no Firebase)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userId': userId,
      'photoUrl': photoUrl,
    };
  }

  // Método para criar um objeto User a partir de um Map (ex: ler do Firebase)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      userId: map['userId'] as String,
      photoUrl: map['photoUrl'] as String?,
    );
  }

  @override
  String toString() {
    return 'User(name: $name, userId: $userId, photoUrl: $photoUrl)';
  }
}
