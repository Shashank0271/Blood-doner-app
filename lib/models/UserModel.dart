import 'dart:convert';
import 'dart:io';

class UserModel {
  final String userName;
  final String email;
  final String bloodGroup;
  final String age;
  final String role;
  final String imageUrl;
  final String imageFileName;
  UserModel({
    required this.userName,
    required this.email,
    required this.bloodGroup,
    required this.age,
    required this.role,
    required this.imageUrl,
    required this.imageFileName,
  });

  UserModel copyWith({
    String? userName,
    String? email,
    String? bloodGroup,
    String? age,
    String? role,
    String? imageUrl,
    String? imageFileName,
  }) {
    return UserModel(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      age: age ?? this.age,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
      imageFileName: imageFileName ?? this.imageFileName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'userName': userName});
    result.addAll({'email': email});
    result.addAll({'bloodGroup': bloodGroup});
    result.addAll({'age': age});
    result.addAll({'role': role});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'imageFileName': imageFileName});
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
      age: map['age'] ?? '',
      role: map['role'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      imageFileName: map['imageFileName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userName: $userName, email: $email, bloodGroup: $bloodGroup, age: $age, role: $role, imageUrl: $imageUrl, imageFileName: $imageFileName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.userName == userName &&
      other.email == email &&
      other.bloodGroup == bloodGroup &&
      other.age == age &&
      other.role == role &&
      other.imageUrl == imageUrl &&
      other.imageFileName == imageFileName;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
      email.hashCode ^
      bloodGroup.hashCode ^
      age.hashCode ^
      role.hashCode ^
      imageUrl.hashCode ^
      imageFileName.hashCode;
  }
}
