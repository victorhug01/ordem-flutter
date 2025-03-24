import 'package:cabeleleila/app/theme.dart';
import 'package:cabeleleila/services/supabse/supabase_service.dart';
import 'package:cabeleleila/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';

class ServicesViewmodel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  Future<List<dynamic>> getServices(BuildContext context) async {
    try {
      notifyListeners();
      final response = await _supabaseService.getServices();
      if (response.isNotEmpty) {
        return response; // Retorna a lista de serviços
      } else {
        throw Exception("Falha ao pegar dados");
      }
    } catch (e) {
      if (context.mounted) {
        SnackbarService.showDetails(
          context,
          "Falha ao encontrar dados de serviços",
          ColorSchemeManagerClass.colorDanger,
        );
      }
      return []; // Retorna uma lista vazia em caso de erro
    } finally {
      notifyListeners();
    }
  }
}

