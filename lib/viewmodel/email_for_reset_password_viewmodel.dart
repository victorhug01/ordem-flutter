import 'package:cabeleleila/app/theme.dart';  // Tema do app, para acessar cores e estilos
import 'package:cabeleleila/models/email_for_reset_password_model.dart';  // Modelo de dados para solicitação de reset de senha
import 'package:cabeleleila/services/supabse/supabase_service.dart';  // Serviço para interagir com o Supabase
import 'package:cabeleleila/widgets/snackbar_widget.dart';  // Widget customizado para exibir mensagens no formato de Snackbar
import 'package:flutter/material.dart';  // Biblioteca principal do Flutter
import 'package:go_router/go_router.dart';  // Biblioteca para navegação entre as telas

/// ViewModel responsável por gerenciar a lógica de solicitação de reset de senha.
/// 
/// Ele interage com o serviço Supabase para enviar o código de reset de senha para o
/// e-mail informado, e exibe mensagens de sucesso ou erro utilizando o SnackBar. 
/// Além disso, cuida da navegação para a tela de verificação do código de OTP.
class EmailForResetPasswordViewmodel extends ChangeNotifier {
  // Serviço Supabase para realizar as operações no banco de dados
  final SupabaseService _supabaseService = SupabaseService();

  /// Função para solicitar o envio do código de reset de senha para o e-mail fornecido.
  ///
  /// Verifica se o formulário de e-mail é válido e, em caso afirmativo, tenta enviar o
  /// código de reset para o e-mail. Caso haja sucesso, navega para a tela de verificação de OTP.
  /// Caso contrário, exibe mensagens de erro.
  Future<void> resetPasswordForEmail(EmailForResetPasswordModel resetPasswordForEmail, BuildContext context, GlobalKey<FormState> emailForRsetPasswordForm) async {
    try {
      // Verifica se o formulário foi validado corretamente
      if (emailForRsetPasswordForm.currentState!.validate()) {
        // Chama o serviço Supabase para enviar o código de reset de senha para o e-mail
        _supabaseService.resetPasswordForEmail(resetPasswordForEmail.email);

        // Se a navegação for possível, exibe a mensagem de sucesso e navega para a tela de verificação de OTP
        if (context.mounted) {
          context.push('/verifyOTP', extra: resetPasswordForEmail.email);  // Navega para a tela de verificação de OTP
          SnackbarService.showDetails(
            context,
            "Código enviado.",  // Mensagem de sucesso
            ColorSchemeManagerClass.colorCorrect,  // Cor de sucesso
          );
        }
      } else {
        // Exibe mensagem de erro se o formulário não for válido
        SnackbarService.showDetails(
          context,
          "Preencha corretamente os campos",  // Mensagem de erro
          ColorSchemeManagerClass.colorDanger,  // Cor de erro
        );
      }
    } catch (e) {
      // Em caso de erro durante o processo, exibe uma mensagem de erro
      if (context.mounted) {
        SnackbarService.showDetails(
          context,
          "Erro ao enviar o código, tente novamente.",  // Mensagem de erro
          ColorSchemeManagerClass.colorDanger,  // Cor de erro
        );
      }
    } finally {
      // Notifica os ouvintes sobre o estado do ViewModel
      notifyListeners();
    }
  }
}
