import 'dart:async';
import 'package:cabeleleila/models/verify_otp_model.dart';
import 'package:cabeleleila/services/supabse/supabase_service.dart';
import 'package:cabeleleila/viewmodel/email_for_reset_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyOTPViewModel extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final SupabaseClient supabase = Supabase.instance.client;
  final SupabaseService _supabaseService = SupabaseService();

  int _remainingTime = 60;
  Timer? _timer;

  int get remainingTime => _remainingTime;

  VerifyOTPViewModel() {
    startCountdown(); // Inicia automaticamente o contador
  }

  void startCountdown() {
    _remainingTime = 60;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        _timer?.cancel();
        notifyListeners(); // Atualiza a UI quando o tempo chega a 0
      }
    });
  }

  Future<void> resendCode(EmailForResetPasswordViewmodel emailViewModel, String email, BuildContext context) async {
    _supabaseService.resetPasswordForEmail(email);
    startCountdown();
  }

  Future<void> verifyOTP(VerifyOtpModel otpModel, BuildContext context) async {
    try {
      await supabase.auth.verifyOTP(
        email: otpModel.email,
        token: otpModel.otpCode,
        type: OtpType.recovery,
      );
      if (context.mounted) {
        context.push('/alter_password');
      }
    } catch (e) {
      if (context.mounted) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Erro',
          text: 'Código inválido. Tente novamente.',
          confirmBtnText: 'Confirmar',
          borderRadius: 5,
        );
      }
      controller.clear();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
