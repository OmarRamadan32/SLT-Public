class RegisterModel {
  String? email;
  String? password;

  RegisterModel({
    this.email,
    this.password,

  });

  RegisterModel copyWith({
    String? email,
    String? password,
  }) {
    return RegisterModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
