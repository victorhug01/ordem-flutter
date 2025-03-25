import 'package:cabeleleila/app/theme.dart';  // Tema do app, para acessar cores e estilos
import 'package:cabeleleila/models/sign_out_model.dart';  // Modelo de dados para o logout, contendo a confirmação do usuário
import 'package:cabeleleila/services/supabse/supabase_service.dart';  // Serviço para interagir com o Supabase e desconectar o usuário
import 'package:cabeleleila/widgets/snackbar_widget.dart';  // Widget customizado para exibir mensagens no formato de Snackbar
import 'package:flutter/material.dart';  // Biblioteca principal do Flutter
import 'package:go_router/go_router.dart';  // Gerenciamento de rotas com GoRouter

/// ViewModel responsável pela lógica de desconexão (logout).
///
/// Ele interage com o serviço Supabase para realizar a desconexão do usuário,
/// exibe um `CircularProgressIndicator` enquanto aguarda a resposta do Supabase,
/// e redireciona para a tela de login. Caso ocorra algum erro, uma mensagem de erro
/// é exibida utilizando o `SnackbarService`.
class SignOutViewModel extends ChangeNotifier {
  // Serviço Supabase para realizar as operações de logout
  final SupabaseService _supabaseService = SupabaseService();

  /// Função que realiza o logout do usuário.
  ///
  /// Se o usuário confirmar a ação de desconexão, o serviço Supabase é chamado
  /// para fazer o logout. Durante o processo, um indicador de progresso é exibido
  /// e, se tudo ocorrer bem, o usuário será redirecionado para a tela de login.
  Future<void> signOut(SignOutModel signOutModel, BuildContext context) async {
    // Exibe um indicador de progresso enquanto o logout está sendo realizado
    if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,  // Impede que o usuário feche a caixa de diálogo
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(color: ColorSchemeManagerClass.colorPrimary),  // Indicador de progresso
          );
        },
      );
    }

    try {
      // Verifica se o usuário confirmou o logout
      if (signOutModel.confirmSignOut) {
        // Chama o serviço Supabase para realizar o logout
        await _supabaseService.signOut();
        notifyListeners();  // Notifica os ouvintes, caso haja alguma mudança no estado
      }
    } catch (e) {
      // Caso ocorra um erro durante o logout, exibe uma mensagem de erro
      if (context.mounted) {
        SnackbarService.showDetails(
          context,
          "Erro ao desconectar, tente novamente mais tarde",  // Mensagem de erro
          ColorSchemeManagerClass.colorDanger,  // Cor de erro
        );
      }
    } finally {
      // Após o logout ou se ocorrer erro, redireciona para a tela de login
      if (context.mounted) {
        context.go('/signIn');  // Redireciona para a tela de login
      }
      notifyListeners();  // Notifica novamente os ouvintes
    }
  }
}
