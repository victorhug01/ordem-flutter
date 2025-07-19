import 'package:cabeleleila/app/theme.dart';  // Tema do app, para acessar cores e estilos
import 'package:cabeleleila/models/alter_password_model.dart';  // Modelo de dados para alteração de senha
import 'package:cabeleleila/services/supabse/supabase_service.dart';  // Serviço para interagir com o Supabase
import 'package:cabeleleila/widgets/snackbar_widget.dart';  // Widget customizado para exibir mensagens no formato de Snackbar
import 'package:flutter/material.dart';  // Biblioteca principal do Flutter
import 'package:go_router/go_router.dart';  // Biblioteca para navegação entre as telas

/// ViewModel responsável por gerenciar a lógica de alteração de senha do usuário.
///
/// Ele interage com o serviço Supabase para atualizar a senha no banco de dados
/// e exibe mensagens de sucesso ou erro utilizando o SnackBar. Além disso,
/// cuida da navegação entre telas.
class AlterPasswordViewmodel extends ChangeNotifier {
  // Serviço Supabase para realizar as operações no banco de dados
  final SupabaseService _supabaseService = SupabaseService();

  /// Função para atualizar a senha do usuário.
  ///
  /// Verifica se o formulário de alteração de senha é válido e, em caso afirmativo,
  /// tenta atualizar a senha no Supabase. Caso haja sucesso, exibe uma mensagem de sucesso
  /// e navega para a tela de navegação principal. Caso contrário, exibe mensagens de erro.
  Future<void> updateUser(AlterPasswordModel alterPasswordModel, BuildContext context, GlobalKey<FormState> alterPasswordForm) async {
    try {
      // Verifica se o formulário foi validado corretamente
      if (alterPasswordForm.currentState!.validate()) {
        // Chama o serviço Supabase para atualizar a senha
        _supabaseService.updateUser(alterPasswordModel.password);

        // Se a navegação for possível, exibe a mensagem de sucesso e navega para a tela de navegação principal
        if (context.mounted) {
          context.go('/');  // Navega para a tela de navegação principal
          SnackbarService.showDetails(
            context,
            "Senha alterada com sucesso!",  // Mensagem de sucesso
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
          "Erro ao alterar senha, tente novamente",  // Mensagem de erro
          ColorSchemeManagerClass.colorDanger,  // Cor de erro
        );
      }
    } finally {
      // Notifica os ouvintes sobre o estado do ViewModel
      notifyListeners();
    }
  }
}
