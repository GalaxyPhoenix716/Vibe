import 'dart:convert';

class UserModel {
  const UserModel({required this.id, required this.name, required this.email});
  final String id;
  final String name;
  final String email;

  UserModel copyWith({String? id, String? name, String? email}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
      email: json['email'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '''
      UserModel(
        id: $id,
        name: $name,
        email: $email,
      )
      ''';
  }

  @override
  bool operator ==(covariant UserModel other) {
    return other.id == id && other.name == name && other.email == email;
  }

  @override
  int get hashCode {
    return Object.hash(id, name, email);
  }
}
