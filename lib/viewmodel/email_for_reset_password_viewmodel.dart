import 'package:ordem/app/theme.dart';
import 'package:ordem/models/email_for_reset_password_model.dart';
import 'package:ordem/services/supabse/supabase_service.dart';
import 'package:ordem/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailForResetPasswordViewmodel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  Future<void> resetPasswordForEmail(
    EmailForResetPasswordModel resetPasswordForEmail,
    BuildContext context,
    GlobalKey<FormState> emailForRsetPasswordForm,
  ) async {
    try {
      if (emailForRsetPasswordForm.currentState!.validate()) {
        _supabaseService.resetPasswordForEmail(resetPasswordForEmail.email);

        if (context.mounted) {
          context.push('/verifyOTP', extra: resetPasswordForEmail.email);
          SnackbarService.showDetails(
            context,
            "Código enviado.",
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
          "Erro ao enviar o código, tente novamente.",
          ColorSchemeManagerClass.colorDanger,
        );
      }
    } finally {
      notifyListeners();
    }
  }
}
