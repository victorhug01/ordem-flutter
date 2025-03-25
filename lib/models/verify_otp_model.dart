/// Modelo que representa a verificação de OTP (código de verificação) para o usuário.
///
/// Contém o e-mail do usuário e o código OTP gerado para validação.
class VerifyOtpModel {
  /// E-mail do usuário que está tentando verificar o código OTP.
  final String email;

  /// Código OTP enviado para o e-mail do usuário.
  final String otpCode;

  /// Construtor da classe VerifyOtpModel.
  ///
  /// [email] é o e-mail do usuário que está tentando validar o código OTP.
  /// [otpCode] é o código de verificação enviado ao e-mail do usuário.
  VerifyOtpModel({
    required this.email,
    required this.otpCode,
  });

  /// Converte o modelo para um mapa (Map) de chave-valor.
  ///
  /// Retorna um mapa com as chaves `'email'` e `'otpCode'`, e os respectivos
  /// valores fornecidos para a verificação do OTP.
  Map<String, String> toMap() {
    return {
      'email': email,
      'otpCode': otpCode,
    };
  }
}
