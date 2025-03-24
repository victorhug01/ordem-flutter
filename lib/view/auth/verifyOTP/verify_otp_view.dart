import 'package:cabeleleila/app/theme.dart';
import 'package:cabeleleila/models/verify_otp_model.dart';
import 'package:cabeleleila/viewmodel/email_for_reset_password_viewmodel.dart';
import 'package:cabeleleila/viewmodel/verify_otp_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerifyOTPView extends StatefulWidget {
  final String email;

  const VerifyOTPView({super.key, required this.email});

  @override
  State<VerifyOTPView> createState() => _VerifyOTPViewState();
}

class _VerifyOTPViewState extends State<VerifyOTPView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Limpar o campo quando a tela for reconstruída
    Provider.of<VerifyOTPViewModel>(context, listen: false).controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final emailViewModel = Provider.of<EmailForResetPasswordViewmodel>(context, listen: false);
    Provider.of<VerifyOTPViewModel>(context, listen: false).startCountdown();

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: ColorSchemeManagerClass.colorSecondary,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          height: double.maxFinite,
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              spacing: 30.0,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(backgroundImage: AssetImage('assets/images/icon.jpg'), radius: 80),
                Column(
                  children: [
                    Text(
                      "Código de verificação enviado para:",
                      style: TextStyle(fontSize: 18, color: ColorSchemeManagerClass.colorBlack),
                    ),
                    Text(
                      widget.email,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorSchemeManagerClass.colorBlack,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Consumer<VerifyOTPViewModel>(
                    builder: (context, verifyOTPViewModel, child) {
                      return Pinput(
                        length: 6,
                        controller: verifyOTPViewModel.controller,
                        focusNode: verifyOTPViewModel.focusNode,
                        defaultPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: ColorSchemeManagerClass.colorPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorSchemeManagerClass.colorPrimary),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onCompleted:
                            (pin) => verifyOTPViewModel.verifyOTP(
                              VerifyOtpModel(email: widget.email, otpCode: pin),
                              context,
                            ),
                      );
                    },
                  ),
                ),
                Consumer<VerifyOTPViewModel>(
                  builder: (context, verifyOTPViewModel, child) {
                    return verifyOTPViewModel.remainingTime > 0
                        ? Text(
                          "Reenviar código em ${verifyOTPViewModel.remainingTime}s",
                          style: TextStyle(fontSize: 16, color: ColorSchemeManagerClass.colorGrey),
                        )
                        : TextButton(
                          onPressed: () {
                            verifyOTPViewModel.resendCode(emailViewModel, widget.email, context);
                          },
                          child: Text(
                            "Reenviar código",
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorSchemeManagerClass.colorPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
