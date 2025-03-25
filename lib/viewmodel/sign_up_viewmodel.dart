import 'package:cabeleleila/app/theme.dart';  // Tema do app, utilizado para acessar cores e estilos personalizados
import 'package:cabeleleila/models/sign_up_model.dart';  // Modelo de dados que contém as informações de cadastro (email e senha)
import 'package:cabeleleila/services/supabse/supabase_service.dart';  // Serviço para interação com o Supabase, usado para realizar o cadastro
import 'package:cabeleleila/widgets/snackbar_widget.dart';  // Widget customizado para exibir mensagens tipo SnackBar
import 'package:flutter/material.dart';  // Biblioteca principal do Flutter
import 'package:go_router/go_router.dart';  // Pacote para gerenciamento de rotas de navegação

/// ViewModel responsável pela lógica de cadastro do usuário.
///
/// Ele interage com o serviço Supabase para realizar o cadastro de um novo usuário,
/// exibe um indicador de progresso enquanto aguarda a resposta do Supabase,
/// e redireciona para a tela de navegação após o sucesso. Caso ocorra algum erro,
/// uma mensagem de erro é exibida utilizando o `SnackbarService`.
class SignUpViewModel extends ChangeNotifier {
  // Instância do serviço Supabase que será utilizada para o cadastro de usuários
  final SupabaseService _supabaseService = SupabaseService();

  /// Função que realiza o cadastro de um novo usuário.
  ///
  /// Verifica se o formulário foi preenchido corretamente. Caso sim, exibe um
  /// indicador de progresso, realiza o cadastro do usuário utilizando o Supabase,
  /// e, em caso de sucesso, redireciona o usuário para a tela de navegação.
  /// Caso ocorra algum erro durante o processo, uma mensagem de erro é exibida.
  Future<void> signUp(
    SignUpModel signUpModel,  // Dados do usuário a serem cadastrados
    BuildContext context,  // Contexto da interface para navegação e exibição de mensagens
    GlobalKey<FormState> signUpKeyForm,  // Chave do formulário para validação
  ) async {
    try {
      notifyListeners();  // Notifica os ouvintes de alterações no estado

      // Verifica se o formulário foi preenchido corretamente
      if (signUpKeyForm.currentState!.validate()) {
        if (context.mounted) {
          // Exibe um indicador de progresso enquanto o cadastro está sendo processado
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

        // Chama o método de cadastro no serviço Supabase
        final response = await _supabaseService.signUp(signUpModel.email, signUpModel.password);

        // Verifica se o cadastro foi bem-sucedido
        if (response.session != null) {
          if (context.mounted) {
            // Redireciona para a tela de navegação
            context.go('/navigationScreens');
            // Exibe uma mensagem de sucesso
            SnackbarService.showDetails(
              context,
              "Cadastro realizado com sucesso!",
              ColorSchemeManagerClass.colorCorrect,  // Cor de sucesso
            );
          }
        } else {
          throw Exception("Falha ao cadastrar, tente novamente.");  // Exceção caso o cadastro falhe
        }
      } else {
        // Caso o formulário não esteja correto, exibe uma mensagem de erro
        SnackbarService.showDetails(
          context,
          "Preencha corretamente os campos",  // Mensagem de erro
          ColorSchemeManagerClass.colorDanger,  // Cor de erro
        );
      }
    } catch (e) {
      // Se ocorrer algum erro durante o processo, exibe a mensagem de erro
      if (context.mounted) {
        SnackbarService.showDetails(
          context,
          e.toString(),  // Exibe o erro gerado
          ColorSchemeManagerClass.colorDanger,  // Cor de erro
        );
      }
    } finally {
      notifyListeners();  // Notifica novamente os ouvintes após o processo
    }
  }
}
