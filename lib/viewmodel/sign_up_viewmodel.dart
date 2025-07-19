import 'package:ordem/app/theme.dart';
import 'package:ordem/models/sign_up_model.dart';
import 'package:ordem/services/supabse/supabase_service.dart';
import 'package:ordem/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  Future<void> signUp(
    SignUpModel signUpModel,
    BuildContext context,
    GlobalKey<FormState> signUpKeyForm,
  ) async {
    try {
      notifyListeners();

      if (signUpKeyForm.currentState!.validate()) {
        if (context.mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorSchemeManagerClass.colorPrimary,
                ),
              );
            },
          );
        }

        final response = await _supabaseService.signUp(
          signUpModel.email,
          signUpModel.password,
        );

        if (response.session != null) {
          if (context.mounted) {
            context.go('/');

            SnackbarService.showDetails(
              context,
              "Cadastro realizado com sucesso!",
              ColorSchemeManagerClass.colorCorrect,
            );
          }
        } else {
          throw Exception("Falha ao cadastrar, tente novamente.");
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
          e.toString(),
          ColorSchemeManagerClass.colorDanger,
        );
      }
    } finally {
      notifyListeners();
    }
  }
}
