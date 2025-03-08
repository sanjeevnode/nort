class User {
  final int? id;
  final String username;
  final String email;
  final String password;
  final String? masterPassword;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isVerified;
  final String? salt;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    this.masterPassword,
    this.createdAt,
    this.updatedAt,
    this.isVerified,
    this.salt,
  });

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
    String? masterPassword,
    String? salt,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isVerified,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      masterPassword: masterPassword ?? this.masterPassword,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isVerified: isVerified ?? this.isVerified,
      salt: salt ?? this.salt,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      masterPassword: json['masterPassword'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isVerified: json['isVerified'] == 1,
      salt: json['salt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'masterPassword': masterPassword,
      'salt': salt,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isVerified': isVerified == true ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, \nusername: $username, \nemail: $email, \npassword: $password, \nmasterPassword: $masterPassword, \ncreatedAt: $createdAt, \nupdatedAt: $updatedAt, \nisVerified: $isVerified\n)';
  }
}