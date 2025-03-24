import 'package:cabeleleila/app/theme.dart';
import 'package:cabeleleila/helpers/responsive_utils.dart';
import 'package:cabeleleila/helpers/validations_mixin.dart';
import 'package:cabeleleila/models/email_for_reset_password_model.dart';
import 'package:cabeleleila/viewmodel/email_for_reset_password_viewmodel.dart';
import 'package:cabeleleila/widgets/button_widget.dart';
import 'package:cabeleleila/widgets/textformfield_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailForResetPasswordView extends StatefulWidget {
  const EmailForResetPasswordView({super.key});

  @override
  State<EmailForResetPasswordView> createState() => _EmailForResetPasswordViewState();
}

class _EmailForResetPasswordViewState extends State<EmailForResetPasswordView> with ValidationMixinClass {
  final _emailController = TextEditingController();
  final _emailForRsetPasswordForm = GlobalKey<FormState>();

  @override
  void dispose() {
     _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailForResetPasswordViewModel = Provider.of<EmailForResetPasswordViewmodel>(context);
    final responsive = ResponsiveUtils(context);
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
            child: Form(
              key: _emailForRsetPasswordForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 50.0,
                children: [
                  Column(
                    spacing: 10.0,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatar(backgroundImage: AssetImage('assets/images/icon.jpg'), radius: 80),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Esqueceu sua senha? Informe seu e-mail e enviaremos um código de redefinição. Verifique sua caixa de entrada (ou spam) e siga as instruções.', textAlign: TextAlign.center),
                      ),
                      TextFormFieldWidget(
                        labelText: 'Email',
                        autofocus: false,
                        controller: _emailController,
                        inputBorderType: OutlineInputBorder(),
                        inputType: TextInputType.emailAddress,
                        obscure: false,
                        sizeInputBorder: 2.0,
                        fillColor: ColorSchemeManagerClass.colorSecondary,
                        filled: true,
                        validator:
                            (value) => combine([
                              () => isNotEmpyt(value),
                              () =>
                                  EmailValidator.validate(value.toString())
                                      ? null
                                      : "Email inválido!",
                              () => maxTwoHundredCharacters(value),
                            ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: responsive.height / 9,
                  ),
                  ButtonWidget(
                    color: ColorSchemeManagerClass.colorPrimary,
                    title: Text(
                      'Enviar',
                      style: TextStyle(
                        color: ColorSchemeManagerClass.colorSecondary,
                        fontSize: TextTheme.of(context).titleMedium!.fontSize,
                      ),
                    ),
                    radius: 10.0,
                    height: 55.0,
                    width: 1.7,
                    onPressed: () async {
                      await emailForResetPasswordViewModel.resetPasswordForEmail(
                        EmailForResetPasswordModel(email: _emailController.text),
                        context, _emailForRsetPasswordForm,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
