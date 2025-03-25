/// Modelo que representa as credenciais de cadastro de um novo usuário.
///
/// Contém o e-mail e a senha fornecidos pelo usuário para a criação de uma nova conta.
class SignUpModel {
  /// E-mail do usuário para o cadastro.
  final String email;

  /// Senha do usuário para o cadastro.
  final String password;

  /// Construtor da classe SignUpModel.
  ///
  /// [email] é o e-mail do usuário que será utilizado para criar a conta.
  /// [password] é a senha do usuário que será utilizada para autenticação.
  SignUpModel({
    required this.email,
    required this.password,
  });

  /// Converte o modelo para um mapa (Map) de chave-valor.
  ///
  /// Retorna um mapa com as chaves `'email'` e `'password'`, e os respectivos
  /// valores fornecidos pelo usuário para o cadastro.
  Map<String, String> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
