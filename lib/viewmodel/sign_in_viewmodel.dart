import 'package:cabeleleila/app/theme.dart';
import 'package:cabeleleila/models/sign_in_model.dart';
import 'package:cabeleleila/services/supabse/supabase_service.dart';
import 'package:cabeleleila/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  Future<void> signIn(
    SignInModel signInModel,
    BuildContext context,
    GlobalKey<FormState> signInKeyForm,
  ) async {
    try {
      notifyListeners();
      if (signInKeyForm.currentState!.validate()) {
        if (context.mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(color: ColorSchemeManagerClass.colorPrimary),
              );
            },
          );
        }
        final response = await _supabaseService.signIn(signInModel.email, signInModel.password);
        if (response.session != null) {
          if (context.mounted) {
            context.go('/home');
          }
        } else {
          throw Exception("Falha ao autenticar");
        }
      } else {
        context.pop();

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
          "Email ou senha inválidos!",
          ColorSchemeManagerClass.colorDanger,
        );
      }
    } finally {
      if(context.mounted){
        context.pop();
      }
      notifyListeners();
    }
  }
}
