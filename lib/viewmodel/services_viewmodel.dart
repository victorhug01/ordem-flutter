import 'package:cabeleleila/app/theme.dart';  // Tema do app, para acessar cores e estilos
import 'package:cabeleleila/services/supabse/supabase_service.dart';  // Serviço para interagir com o Supabase e buscar dados
import 'package:cabeleleila/widgets/snackbar_widget.dart';  // Widget customizado para exibir mensagens no formato de Snackbar
import 'package:flutter/material.dart';  // Biblioteca principal do Flutter

/// ViewModel responsável por gerenciar a lógica para obtenção da lista de serviços.
///
/// Ele interage com o serviço Supabase para recuperar dados de serviços e exibe
/// mensagens de erro ou sucesso utilizando o SnackBar. Além disso, notifica a UI
/// sempre que os dados forem recuperados ou quando ocorrer um erro.
class ServicesViewmodel extends ChangeNotifier {
  // Serviço Supabase para realizar as operações de busca de serviços
  final SupabaseService _supabaseService = SupabaseService();

  /// Função que busca a lista de serviços do Supabase.
  ///
  /// A função tenta buscar os dados de serviços através do `SupabaseService`. 
  /// Se a resposta for bem-sucedida e contiver serviços, ela retorna a lista de serviços.
  /// Se ocorrer um erro, uma mensagem de erro será exibida através de um SnackBar,
  /// e uma lista vazia será retornada.
  Future<List<dynamic>> getServices(BuildContext context) async {
    try {
      // Notifica os ouvintes para atualizar a UI, caso necessário
      notifyListeners();

      // Chama o serviço Supabase para buscar os serviços
      final response = await _supabaseService.getServices();

      // Se a resposta contiver serviços, retorna a lista
      if (response.isNotEmpty) {
        return response; // Retorna a lista de serviços
      } else {
        // Lança uma exceção caso os serviços não sejam encontrados
        throw Exception("Falha ao pegar dados");
      }
    } catch (e) {
      // Em caso de erro, exibe a mensagem de erro via SnackBar
      if (context.mounted) {
        SnackbarService.showDetails(
          context,
          "Falha ao encontrar dados de serviços",  // Mensagem de erro
          ColorSchemeManagerClass.colorDanger,  // Cor de erro
        );
      }

      // Retorna uma lista vazia caso haja falha na obtenção dos dados
      return [];
    } finally {
      // Notifica os ouvintes novamente para atualizar a UI, caso necessário
      notifyListeners();
    }
  }
}
