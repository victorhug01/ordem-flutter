import 'package:cabeleleila/helpers/responsive_utils.dart';  // Utilitário para responsividade
import 'package:flutter/material.dart';  // Biblioteca principal do Flutter

/// Um widget personalizado para um botão responsivo.
///
/// Este widget permite a criação de um botão com uma personalização flexível,
/// incluindo a cor, o título, o tamanho, o raio das bordas, e o comportamento de clique.
/// Ele também usa um utilitário de responsividade para ajustar o tamanho do botão conforme o dispositivo.
class ButtonWidget extends StatefulWidget {
  // Função a ser chamada quando o botão for pressionado
  final VoidCallback onPressed;
  // Título do botão, pode ser qualquer widget
  final Widget title;
  // Altura do botão
  final double height;
  // Largura do botão, relativa à largura da tela
  final double width;
  // Cor de fundo do botão
  final Color color;
  // Raio das bordas do botão
  final double radius;

  // Construtor do botão, com todos os parâmetros necessários para personalização
  const ButtonWidget({
    super.key,
    required this.onPressed,  // Função de callback para o clique
    required this.title,  // Título do botão
    required this.height,  // Altura do botão
    required this.width,  // Largura do botão (relativo à largura da tela)
    required this.color,  // Cor do botão
    required this.radius,  // Raio das bordas do botão
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    // Responsividade para ajustar a largura do botão conforme a tela
    final responsive = ResponsiveUtils(context);

    return SizedBox(
      height: widget.height,  // Define a altura do botão
      width: responsive.width / widget.width,  // Ajusta a largura do botão para ser proporcional à largura da tela
      child: ElevatedButton(
        onPressed: widget.onPressed,  // Ação a ser executada quando o botão for pressionado
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,  // Define a cor de fundo do botão
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius),  // Define o raio das bordas para o efeito arredondado
          ),
        ),
        child: widget.title,  // O conteúdo do botão (pode ser texto ou outros widgets)
      ),
    );
  }
}
