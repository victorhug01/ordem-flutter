import 'package:cabeleleila/app/theme.dart';  // Tema do app, para acessar cores e estilos
import 'package:cabeleleila/models/sign_in_model.dart';  // Modelo de dados para login, contendo o email e senha
import 'package:cabeleleila/services/supabse/supabase_service.dart';  // Serviço para interagir com o Supabase e autenticar o usuário
import 'package:cabeleleila/widgets/snackbar_widget.dart';  // Widget customizado para exibir mensagens no formato de Snackbar
import 'package:flutter/material.dart';  // Biblioteca principal do Flutter
import 'package:go_router/go_router.dart';  // Gerenciamento de rotas com GoRouter

/// ViewModel responsável pela lógica de autenticação (login).
///
/// Ele interage com o serviço Supabase para realizar o login do usuário,
/// exibe um `CircularProgressIndicator` enquanto aguarda a resposta da autenticação,
/// e exibe mensagens de erro ou sucesso utilizando o SnackBar. Após a autenticação
/// bem-sucedida, redireciona o usuário para a tela de navegação.
class SignInViewModel extends ChangeNotifier {
  // Serviço Supabase para realizar as operações de autenticação
  final SupabaseService _supabaseService = SupabaseService();

  /// Função que autentica o usuário (login).
  ///
  /// A função valida os campos de entrada (email e senha), exibe um indicador
  /// de progresso enquanto aguarda a resposta do Supabase, e redireciona para a tela
  /// de navegação se a autenticação for bem-sucedida. Se ocorrer algum erro, ele
  /// exibe uma mensagem de erro utilizando o `SnackbarService`.
  Future<void> signIn(
    SignInModel signInModel,  // Modelo de dados com email e senha
    BuildContext context,  // Contexto para navegação e exibição de mensagens
    GlobalKey<FormState> signInKeyForm,  // Chave do formulário para validação
  ) async {
    try {
      // Notifica os ouvintes para atualizar a UI, caso necessário
      notifyListeners();

      // Valida o formulário
      if (signInKeyForm.currentState!.validate()) {
        // Exibe o indicador de progresso enquanto a autenticação está sendo realizada
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

        // Chama o serviço Supabase para autenticar o usuário
        final response = await _supabaseService.signIn(signInModel.email, signInModel.password);

        // Se a sessão foi criada com sucesso, redireciona o usuário
        if (response.session != null) {
          if (context.mounted) {
            context.go('/navigationScreens');  // Redireciona para a tela de navegação
          }
        } else {
          // Se a autenticação falhar, lança uma exceção
          throw Exception("Falha ao autenticar");
        }
      } else {
        // Se a validação do formulário falhar, fecha o indicador de progresso
        context.pop();

        // Exibe uma mensagem de erro informando o usuário para preencher corretamente
        SnackbarService.showDetails(
          context,
          "Preencha corretamente os campos",
          ColorSchemeManagerClass.colorDanger,  // Cor de erro
        );
      }
    } catch (e) {
      // Em caso de erro, exibe a mensagem de erro com Snackbar
      if (context.mounted) {
        SnackbarService.showDetails(
          context,
          "Email ou senha inválidos!",  // Mensagem de erro
          ColorSchemeManagerClass.colorDanger,  // Cor de erro
        );
      }
    } finally {
      // Fecha o indicador de progresso, caso ainda esteja visível
      if(context.mounted){
        context.pop();  // Fecha o diálogo de carregamento
      }
      // Notifica os ouvintes novamente para atualizar a UI, caso necessário
      notifyListeners();
    }
  }
}
