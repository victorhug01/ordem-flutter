class EmailForResetPasswordModel {
  final String email;

  EmailForResetPasswordModel({required this.email});

  Map<String, String> toMap() {
    return {'email': email};
  }
}
