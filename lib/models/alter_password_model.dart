/// Modelo que representa a alteração de senha do usuário.
///
/// Contém a nova senha que será definida para o usuário.
class AlterPasswordModel {
  /// Nova senha do usuário.
  final String password;

  /// Construtor da classe AlterPasswordModel.
  ///
  /// [password] é a nova senha que será atribuída ao usuário.
  AlterPasswordModel({
    required this.password,
  });

  /// Converte o modelo para um mapa (Map) de chave-valor.
  ///
  /// Retorna um mapa com a chave `'password'` e o valor da nova senha.
  Map<String, String> toMap() {
    return {
      'password': password,
    };
  }
}
