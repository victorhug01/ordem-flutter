import 'package:cabeleleila/app/theme.dart';
import 'package:cabeleleila/models/alter_password_model.dart';
import 'package:cabeleleila/services/supabse/supabase_service.dart';
import 'package:cabeleleila/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlterPasswordViewmodel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  Future<void> updateUser(AlterPasswordModel alterPasswordModel ,BuildContext context, GlobalKey<FormState> alterPasswordForm) async {
    try {
      if (alterPasswordForm.currentState!.validate()) {
        _supabaseService.updateUser(alterPasswordModel.password);
        if (context.mounted) {
          context.go('/navigationScreens');
          SnackbarService.showDetails(
          context,
          "Senha alterada com sucesso!",
          ColorSchemeManagerClass.colorCorrect,
        );
        }
      } else {
        SnackbarService.showDetails(
          context,
          "Preencha corretamente os campos",
          ColorSchemeManagerClass.colorDanger,
        );
      }
    } catch (e) {
      if (context.mounted) {
        SnackbarService.showDetails(
          context,
          "Erro ao alterar senha, tente novamente",
          ColorSchemeManagerClass.colorDanger,
        );
      }
    } finally {
      notifyListeners();
    }
  }
}
