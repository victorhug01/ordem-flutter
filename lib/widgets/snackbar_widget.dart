import 'package:flutter/material.dart';  // Importa a biblioteca principal do Flutter

/// Serviço para exibir Snackbars personalizados no aplicativo.
///
/// O `SnackbarService` fornece uma maneira centralizada de exibir mensagens 
/// no formato de `SnackBar` em qualquer lugar do aplicativo.
class SnackbarService {
  /// Exibe um SnackBar com uma mensagem personalizada, cor de fundo e duração.
  ///
  /// Este método é estático, podendo ser chamado de qualquer lugar sem necessidade
  /// de instanciar a classe. O `SnackBar` é exibido na parte inferior da tela,
  /// com a cor e a mensagem passadas como parâmetros.
  ///
  /// [context] - O contexto de onde o `SnackBar` será exibido.
  /// [message] - A mensagem que será exibida dentro do `SnackBar`.
  /// [color] - A cor de fundo do `SnackBar`.
  static void showDetails(BuildContext context, String message, Color color) {
    // Exibe o SnackBar usando o ScaffoldMessenger para mostrar a mensagem na tela.
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(message),  // Texto da mensagem a ser exibida no SnackBar
        backgroundColor: color,  // Cor de fundo do SnackBar
        duration: Duration(seconds: 3),  // Duração do SnackBar (3 segundos)
        behavior: SnackBarBehavior.floating,  // Exibe o SnackBar flutuando acima da tela
        margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),  // Margens do SnackBar
      ),
    );
  }
}
