import 'package:cabeleleila/app/theme.dart';
import 'package:cabeleleila/helpers/validations_mixin.dart';
import 'package:cabeleleila/models/sign_in_model.dart';
import 'package:cabeleleila/viewmodel/sign_in_viewmodel.dart';
import 'package:cabeleleila/widgets/button_widget.dart';
import 'package:cabeleleila/widgets/textformfield_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> with ValidationMixinClass {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signInKeyForm = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
     _emailController.dispose(); // Libera o controlador de email quando a tela for descartada
    _passwordController.dispose(); // Libera o controlador de senha quando a tela for descartada
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInViewModel = Provider.of<SignInViewModel>(context); // Acessa o ViewModel de login
    return Scaffold(
      extendBody: true,
      backgroundColor: ColorSchemeManagerClass.colorSecondary,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          height: double.maxFinite,
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: _signInKeyForm, // Formulário de validação
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 50.0,
                children: [
                  Column(
                    spacing: 20.0,
                    children: [
                      CircleAvatar(backgroundImage: AssetImage('assets/images/icon.jpg'), radius: 80), // Ícone de usuário
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Faça login com seu e-mail e senha para acessar sua conta. Caso ainda não tenha uma, cadastre-se rapidamente. Segurança garantida!',
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  // Campo de email
                  Column(
                    spacing: 15.0,
                    children: [
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
                            (value) => combine([ // Validação do email
                              () => isNotEmpyt(value),
                              () =>
                                  EmailValidator.validate(value.toString())
                                      ? null
                                      : "Email inválido!",
                              () => maxTwoHundredCharacters(value),
                            ]),
                      ),
                      Column(
                        children: [
                          // Campo de senha
                          TextFormFieldWidget(
                            labelText: 'Senha',
                            autofocus: false,
                            controller: _passwordController,
                            inputBorderType: OutlineInputBorder(),
                            inputType: TextInputType.emailAddress,
                            obscure: _obscurePassword, // Oculta ou exibe a senha
                            sizeInputBorder: 2.0,
                            fillColor: ColorSchemeManagerClass.colorSecondary,
                            filled: true,
                            iconSuffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword; // Alterna visibilidade da senha
                                });
                              },
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: ColorSchemeManagerClass.colorPrimary,
                              ),
                            ),
                            validator:
                                (value) => combine([ // Validação da senha
                                  () => isNotEmpyt(value),
                                  () => hasSixChars(value),
                                  () => maxTwoHundredCharacters(value),
                                ]),
                          ),
                          // Link para recuperação de senha
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () => context.push('/emailForResetPasswordView'),
                              child: Text(
                                "Esqueci minha senha",
                                style: TextStyle(
                                  color: ColorSchemeManagerClass.colorBlack,
                                  decoration: TextDecoration.underline,
                                  decorationColor: ColorSchemeManagerClass.colorPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Botão de login
                  ButtonWidget(
                    color: ColorSchemeManagerClass.colorPrimary,
                    title: Text(
                      'Conectar',
                      style: TextStyle(
                        color: ColorSchemeManagerClass.colorSecondary,
                        fontSize: TextTheme.of(context).titleMedium!.fontSize,
                      ),
                    ),
                    radius: 10.0,
                    height: 55.0,
                    width: 1.7,
                    onPressed: () async {
                      await signInViewModel.signIn(
                        SignInModel( email: _emailController.text, password: _passwordController.text), // Envia as credenciais
                        context, _signInKeyForm,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Center(
          child: GestureDetector(
            onTap: () => context.push('/signUp'), // Redireciona para a tela de cadastro
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Não tem um login?',
                  style: TextStyle(
                    color: ColorSchemeManagerClass.colorBlack,
                    fontSize: TextTheme.of(context).titleMedium!.fontSize,
                  ),
                ),
                Text(
                  'Cadastre-se',
                  style: TextStyle(
                    color: ColorSchemeManagerClass.colorPrimary,
                    fontSize: TextTheme.of(context).titleMedium!.fontSize,
                    decoration: TextDecoration.underline,
                    decorationColor: ColorSchemeManagerClass.colorPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
