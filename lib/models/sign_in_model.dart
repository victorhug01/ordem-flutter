/// Modelo que representa as credenciais de login do usuário.
///
/// Contém o e-mail e a senha fornecidos pelo usuário para autenticação.
class SignInModel {
  /// E-mail do usuário para login.
  final String email;

  /// Senha do usuário para login.
  final String password;

  /// Construtor da classe SignInModel.
  ///
  /// [email] é o e-mail do usuário que será usado para login.
  /// [password] é a senha do usuário que será usada para autenticação.
  SignInModel({
    required this.email,
    required this.password,
  });

  /// Converte o modelo para um mapa (Map) de chave-valor.
  ///
  /// Retorna um mapa com as chaves `'email'` e `'password'`, e os respectivos
  /// valores fornecidos pelo usuário para login.
  Map<String, String> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
