class User {
  String id;
  String fullname;
  String email;
  String password; // Consider security implications of storing passwords

  User({required this.id, required this.fullname, required this.email, required this.password});


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullname: json['fullname'],
      email: json['email'],
      password: json['password'],
      id: json['_id'],
    );
  }
  // Method to update user data
  User copyWith({String? name, String? email, String? password}) {
    return User(
      id: this.id,
      fullname: name ?? this.fullname,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullname': fullname,
      'email': email,
      'password': password,
    };
  }
}
