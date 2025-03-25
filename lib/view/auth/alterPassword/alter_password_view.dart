import 'package:cabeleleila/app/theme.dart';
import 'package:cabeleleila/helpers/validations_mixin.dart';
import 'package:cabeleleila/models/alter_password_model.dart';
import 'package:cabeleleila/viewmodel/alter_password_viewmodel.dart';
import 'package:cabeleleila/widgets/button_widget.dart';
import 'package:cabeleleila/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AlterPasswordView extends StatefulWidget {
  const AlterPasswordView({super.key});

  @override
  State<AlterPasswordView> createState() => _AlterPasswordViewState();
}

class _AlterPasswordViewState extends State<AlterPasswordView> with ValidationMixinClass {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _alterPasswordForm = GlobalKey<FormState>();
  bool _obscurePassword = true; // Controla a visibilidade da senha

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alterPasswordViewmodel = Provider.of<AlterPasswordViewmodel>(context); // Acessa o ViewModel
    return Scaffold(
      appBar: AppBar(),
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
              key: _alterPasswordForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 50.0,
                children: [
                  CircleAvatar(backgroundImage: AssetImage('assets/images/icon.jpg'), radius: 80), // Ícone do usuário
                  Column(
                    spacing: 15.0,
                    children: [
                      // Campo de senha
                      TextFormFieldWidget(
                        labelText: 'Senha',
                        autofocus: false,
                        controller: _passwordController,
                        inputBorderType: OutlineInputBorder(),
                        inputType: TextInputType.emailAddress,
                        obscure: _obscurePassword,
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
                            (value) => combine([ // Validações para a senha
                              () => isNotEmpyt(value),
                              () => hasSixChars(value),
                              () => maxTwoHundredCharacters(value),
                            ]),
                      ),
                      // Campo de confirmação de senha
                      TextFormFieldWidget(
                        labelText: 'Confirmar senha',
                        autofocus: false,
                        controller: _confirmPasswordController,
                        inputBorderType: OutlineInputBorder(),
                        inputType: TextInputType.emailAddress,
                        obscure: _obscurePassword,
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
                            (value) => combine([ // Validações para a confirmação de senha
                              () => isNotEmpyt(value),
                              () => hasSixChars(value),
                              () => maxTwoHundredCharacters(value),
                              () => value != _passwordController.text ? 'Senhas diferentes' : null, // Senhas precisam ser iguais
                            ]),
                      ),
                    ],
                  ),
                  // Botão para redefinir senha
                  ButtonWidget(
                    color: ColorSchemeManagerClass.colorPrimary,
                    title: Text(
                      'Redefinir',
                      style: TextStyle(
                        color: ColorSchemeManagerClass.colorSecondary,
                        fontSize: TextTheme.of(context).titleMedium!.fontSize,
                      ),
                    ),
                    radius: 10.0,
                    height: 55.0,
                    width: 1.7,
                    onPressed: () async {
                      await alterPasswordViewmodel.updateUser(
                        AlterPasswordModel(password: _passwordController.text), // Atualiza a senha
                        context, _alterPasswordForm,
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
