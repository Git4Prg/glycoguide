class UserModel {
  final String? id;
  final String? userName;
  final String? email;
  final String? password;

  const UserModel({
    this.id,
    required this.userName,
    required this.email,
    required this.password,
  });

  toJson() {
    return {
      "Username": userName,
      "Email": email,
      "Password": password,
    };
  }
}
