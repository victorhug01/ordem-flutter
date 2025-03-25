import 'package:cabeleleila/app/theme.dart';
import 'package:cabeleleila/helpers/validations_mixin.dart';
import 'package:cabeleleila/models/sign_up_model.dart';
import 'package:cabeleleila/viewmodel/sign_up_viewmodel.dart';
import 'package:cabeleleila/widgets/button_widget.dart';
import 'package:cabeleleila/widgets/textformfield_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with ValidationMixinClass {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _signUpKeyForm = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose(); // Libera o controlador de email
    _passwordController.dispose(); // Libera o controlador de senha
    _confirmPasswordController.dispose(); // Libera o controlador de confirmação de senha
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = Provider.of<SignUpViewModel>(context); // Acessa o ViewModel de cadastro
    return Scaffold(
      appBar: AppBar(), // Barra de navegação
      backgroundColor: ColorSchemeManagerClass.colorSecondary,
      body: SafeArea(
        child: Container(
          color: ColorSchemeManagerClass.colorSecondary,
          alignment: Alignment.center,
          height: double.maxFinite,
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: _signUpKeyForm, // Formulário de validação
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 30.0,
                children: [
                  Column(
                    spacing: 10.0,
                    children: [
                      CircleAvatar(backgroundImage: AssetImage('assets/images/icon.jpg'), radius: 80), // Ícone de usuário
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Bem-vindo! Para aproveitar todos os recursos, cadastre-se agora mesmo. É rápido, fácil e seguro.',
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  // Campos de email, senha e confirmação de senha
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
                            (value) => combine([ // Validação de email
                              () => isNotEmpyt(value),
                              () =>
                                  EmailValidator.validate(value.toString())
                                      ? null
                                      : "Email inválido!",
                              () => maxTwoHundredCharacters(value),
                            ]),
                      ),
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
                            (value) => combine([ // Validação de senha
                              () => isNotEmpyt(value),
                              () => hasSixChars(value),
                              () => maxTwoHundredCharacters(value),
                            ]),
                      ),
                      TextFormFieldWidget(
                        labelText: 'Confirmar senha',
                        autofocus: false,
                        controller: _confirmPasswordController,
                        inputBorderType: OutlineInputBorder(),
                        inputType: TextInputType.emailAddress,
                        obscure: _obscurePassword, // Confirmação de senha
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
                            (value) => combine([ // Validação da confirmação de senha
                              () => isNotEmpyt(value),
                              () => hasSixChars(value),
                              () => maxTwoHundredCharacters(value),
                              () => value != _passwordController.text ? 'Senhas diferentes!' : null, // Verifica se a senha e confirmação são iguais
                            ]),
                      ),
                    ],
                  ),
                  // Botão de cadastro
                  ButtonWidget(
                    color: ColorSchemeManagerClass.colorPrimary,
                    title: Text(
                      'Cadastrar',
                      style: TextStyle(
                        color: ColorSchemeManagerClass.colorSecondary,
                        fontSize: TextTheme.of(context).titleMedium!.fontSize,
                      ),
                    ),
                    radius: 10.0,
                    height: 55.0,
                    width: 1.7,
                    onPressed: () async {
                      await signUpViewModel.signUp(
                        SignUpModel( email: _emailController.text, password: _passwordController.text), // Envia dados de cadastro
                        context, _signUpKeyForm,
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
            onTap: () => context.pop(), // Volta para a tela anterior (login)
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Já possui uma conta?',
                  style: TextStyle(
                    color: ColorSchemeManagerClass.colorPrimary,
                    fontSize: TextTheme.of(context).titleMedium!.fontSize,
                  ),
                ),
                Text(
                  'Clique aqui.',
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
