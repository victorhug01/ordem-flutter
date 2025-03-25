import 'package:cabeleleila/helpers/responsive_utils.dart';  // Responsividade da tela para adaptar o layout em diferentes tamanhos
import 'package:flutter/material.dart';  // Biblioteca principal do Flutter
import 'package:lottie/lottie.dart';  // Biblioteca para exibir animações Lottie

/// A tela exibida quando não há conexão com a internet.
///
/// Esta tela contém uma animação e uma mensagem informando ao usuário
/// que não há conexão disponível. O layout é responsivo e se adapta
/// ao tamanho da tela do dispositivo.
class InternetNotFoundView extends StatelessWidget {
  // Construtor da classe, com a chave opcional (super.key)
  const InternetNotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsividade: obtém o objeto de utilitários para adaptar o layout à tela do dispositivo
    final responsive = ResponsiveUtils(context);
    
    return Scaffold(
      // SafeArea garante que o conteúdo da tela não seja sobreposto por áreas do sistema (como a barra de status)
      body: SafeArea(
        child: Column(
          // Alinhamento centralizado para todos os widgets
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // `spacing`: define o espaço entre os widgets (disponível nas versões mais recentes do Flutter)
          spacing: 30.0,
          children: [
            // Lottie Asset: exibe a animação que representa a falta de conexão (em formato JSON)
            SizedBox(
              width: responsive.width,  // Responsividade: ajusta a largura da animação com base no tamanho da tela
              child: Lottie.asset(
                'assets/lotties/lottie404.json',  // Caminho para a animação
                width: 250,  // Largura fixa da animação
                height: 250,  // Altura fixa da animação
              ),
            ),
            // Texto informativo que diz ao usuário que não há conexão
            Text(
              'Sem conexão',  // Texto a ser exibido
              style: TextStyle(
                fontSize: TextTheme.of(context).headlineSmall!.fontSize,  // Tamanho da fonte adaptado do tema do app
              ),
            ),
          ],
        ),
      ),
    );
  }
}
