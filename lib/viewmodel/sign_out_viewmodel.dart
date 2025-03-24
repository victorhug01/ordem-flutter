import 'package:cabeleleila/app/theme.dart';
import 'package:cabeleleila/models/sign_out_model.dart';
import 'package:cabeleleila/services/supabse/supabase_service.dart';
import 'package:cabeleleila/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignOutViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  Future<void> signOut(SignOutModel signOutModel, BuildContext context) async {
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
    try {
      if (signOutModel.confirmSignOut) {
        await _supabaseService.signOut();
        notifyListeners();
      }
    } catch (e) {
      if (context.mounted) {
        SnackbarService.showDetails(
          context,
          "Erro ao desconectar, tente novamente mais tarde",
          ColorSchemeManagerClass.colorDanger,
        );
      }
    } finally {
      if (context.mounted) {
        context.go('/signIn');
      }
      notifyListeners();
    }
  }
}
