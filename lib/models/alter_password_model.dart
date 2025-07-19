class AlterPasswordModel {
  final String password;

  AlterPasswordModel({required this.password});

  Map<String, String> toMap() {
    return {'password': password};
  }
}
