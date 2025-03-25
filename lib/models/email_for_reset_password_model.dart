/// Modelo que representa o e-mail para a recuperação de senha.
///
/// Contém o e-mail do usuário para o qual o link de redefinição de senha
/// será enviado.
class EmailForResetPasswordModel {
  /// E-mail do usuário para a recuperação de senha.
  final String email;

  /// Construtor da classe EmailForResetPasswordModel.
  ///
  /// [email] é o e-mail do usuário que será usado para enviar o link de
  /// recuperação de senha.
  EmailForResetPasswordModel({
    required this.email,
  });

  /// Converte o modelo para um mapa (Map) de chave-valor.
  ///
  /// Retorna um mapa com a chave `'email'` e o valor do e-mail fornecido.
  Map<String, String> toMap() {
    return {
      'email': email,
    };
  }
}
