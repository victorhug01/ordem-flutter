/// Modelo que representa a confirmação de logout do usuário.
///
/// Contém um booleano que indica se o usuário confirmou ou não o logout.
class SignOutModel {
  /// Indica se o usuário confirmou o logout.
  /// O valor padrão é `true`, indicando que o logout foi confirmado.
  final bool confirmSignOut;

  /// Construtor da classe SignOutModel.
  ///
  /// [confirmSignOut] é um parâmetro opcional que indica se o logout foi
  /// confirmado. O valor padrão é `true`.
  SignOutModel({this.confirmSignOut = true});
}
