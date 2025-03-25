import 'package:cabeleleila/models/sign_out_model.dart';
import 'package:cabeleleila/viewmodel/sign_out_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isLoggingOut = false; // Para controlar o estado do botão de logout

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Home"),
        actions: [
          _isLoggingOut
              ? const CircularProgressIndicator() // Mostrar indicador de progresso
              : IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () async {
                    setState(() {
                      _isLoggingOut = true; // Ativar indicador de progresso
                    });

                    // Realizar o logout
                    await context.read<SignOutViewModel>().signOut(SignOutModel(), context);

                    setState(() {
                      _isLoggingOut = false; // Desativar indicador de progresso
                    });

                    // Após o logout, redireciona para a tela de login
                    // context.push('/signIn'); // Ou use outra navegação dependendo do seu fluxo
                  },
                ),
        ],
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
