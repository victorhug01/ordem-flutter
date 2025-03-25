import 'dart:async';  // Biblioteca para manipulação de timers
import 'package:cabeleleila/models/verify_otp_model.dart';  // Modelo que contém os dados necessários para a verificação do código OTP
import 'package:cabeleleila/services/supabse/supabase_service.dart';  // Serviço que interage com o Supabase para recuperação de senha
import 'package:cabeleleila/viewmodel/email_for_reset_password_viewmodel.dart';  // ViewModel responsável pelo envio do código de recuperação de senha
import 'package:flutter/material.dart';  // Biblioteca principal do Flutter
import 'package:go_router/go_router.dart';  // Pacote para gerenciamento de rotas de navegação
import 'package:quickalert/models/quickalert_type.dart';  // Tipo de alerta usado para exibir o erro de código OTP inválido
import 'package:quickalert/widgets/quickalert_dialog.dart';  // Widget para exibição de alertas personalizados
import 'package:supabase_flutter/supabase_flutter.dart';  // Pacote para interação com o Supabase, incluindo autenticação e verificação de OTP

/// ViewModel responsável pela verificação do código OTP enviado por email.
///
/// Esta classe gerencia o processo de verificação do código OTP, incluindo a contagem regressiva para
/// reenviar o código, a validação do código recebido e a navegação para a tela de alteração de senha.
/// Caso o código seja inválido, exibe um alerta de erro ao usuário.
class VerifyOTPViewModel extends ChangeNotifier {
  // Controlador de texto para o campo de código OTP
  final TextEditingController controller = TextEditingController();
  // Foco para o campo de código OTP
  final FocusNode focusNode = FocusNode();
  // Instância do cliente Supabase para realizar a verificação de OTP
  final SupabaseClient supabase = Supabase.instance.client;
  // Instância do serviço Supabase para ações como redefinir senha
  final SupabaseService _supabaseService = SupabaseService();

  // Tempo restante para reenviar o código, em segundos
  int _remainingTime = 60;
  // Timer para contagem regressiva
  Timer? _timer;

  // Getter para acessar o tempo restante
  int get remainingTime => _remainingTime;

  /// Construtor da classe.
  /// Inicia automaticamente a contagem regressiva e limpa o campo de código OTP.
  VerifyOTPViewModel() {
    startCountdown();  // Inicia automaticamente o contador
    controller.clear();  // Limpa o campo de PIN ao reenviar o código
    notifyListeners();
  }

  /// Inicia a contagem regressiva de 60 segundos para reenviar o código.
  void startCountdown() {
    _remainingTime = 60;  // Reinicia o contador para 60 segundos
    _timer?.cancel();  // Cancela qualquer contador anterior
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;  // Decrementa o tempo restante
        notifyListeners();  // Notifica os ouvintes para atualizar a UI
      } else {
        _timer?.cancel();  // Cancela o timer quando o tempo chegar a 0
        notifyListeners();  // Notifica para atualizar a UI quando o tempo acabar
      }
    });
  }

  /// Envia um novo código de recuperação para o email.
  /// Reinicia a contagem regressiva após o reenvio do código.
  Future<void> resendCode(EmailForResetPasswordViewmodel emailViewModel, String email, BuildContext context) async {
    _supabaseService.resetPasswordForEmail(email);  // Reenvia o código de recuperação
    startCountdown();  // Reinicia a contagem regressiva
  }

  /// Verifica o código OTP inserido pelo usuário.
  ///
  /// Caso o código seja válido, o usuário é redirecionado para a tela de alteração de senha.
  /// Caso contrário, é exibido um alerta de erro informando que o código é inválido.
  Future<void> verifyOTP(VerifyOtpModel otpModel, BuildContext context) async {
    try {
      // Verifica o código OTP utilizando o cliente Supabase
      await supabase.auth.verifyOTP(
        email: otpModel.email,  // Email do usuário
        token: otpModel.otpCode,  // Código OTP inserido
        type: OtpType.recovery,  // Tipo de OTP (recuperação de senha)
      );
      
      // Se a verificação for bem-sucedida, redireciona para a tela de alteração de senha
      if (context.mounted) {
        controller.clear();  // Limpa o campo de código OTP
        context.go('/alterPasswordView');  // Navega para a tela de alteração de senha
      }
    } catch (e) {
      // Se ocorrer um erro (código OTP inválido), exibe um alerta de erro
      if (context.mounted) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,  // Tipo de alerta (erro)
          title: 'Erro',  // Título do alerta
          text: 'Código inválido. Tente novamente.',  // Mensagem do alerta
          confirmBtnText: 'Confirmar',  // Texto do botão de confirmação
          borderRadius: 5,  // Raio da borda do alerta
        );
      }
      controller.clear();  // Limpa o campo de código OTP após o erro
    }
  }

  /// Cancela o timer e limpa os recursos quando o `ViewModel` for destruído.
  @override
  void dispose() {
    _timer?.cancel();  // Cancela o timer se existir
    controller.dispose();  // Limpa o controlador de texto
    focusNode.dispose();  // Limpa o foco
    super.dispose();  // Chama o dispose da classe pai
  }
}
