import 'package:cabeleleila/app/theme.dart';
import 'package:flutter/material.dart';

/// Widget customizado que estende o `TextFormField` do Flutter.
/// 
/// O `TextFormFieldWidget` oferece várias opções de personalização para campos de texto
/// dentro do formulário, como bordas, ícones prefixados e sufixados, validação e muito mais.
class TextFormFieldWidget extends StatefulWidget {
  final String? hintText;  // Texto a ser exibido quando o campo estiver vazio
  final ValueChanged<String>? onChanged;  // Função de callback para mudanças no texto
  final bool? enable;  // Define se o campo é habilitado ou não
  final String? labelText;  // Texto do rótulo acima do campo
  final Widget? iconPrefix;  // Ícone a ser exibido à esquerda do campo
  final IconButton? iconSuffix;  // Ícone a ser exibido à direita do campo
  final bool obscure;  // Define se o campo deve ser mascarado (ex.: para senha)
  final bool autofocus;  // Define se o campo deve receber o foco automaticamente
  final String? Function(String?)? validator;  // Função de validação para o campo
  final TextInputType inputType;  // Tipo de entrada do teclado (texto, número, etc.)
  final TextEditingController controller;  // Controlador de texto para o campo
  final InputBorder inputBorderType;  // Tipo de borda do campo (ex.: OutlineInputBorder)
  final double sizeInputBorder;  // Espessura da borda
  final Color? colorBorderInput;  // Cor da borda do campo
  final double? paddingLeftInput;  // Espaçamento à esquerda do campo de texto
  final bool? filled;  // Define se o campo deve ter fundo preenchido
  final Color? fillColor;  // Cor de fundo do campo, se `filled` for verdadeiro

  const TextFormFieldWidget({
    super.key,
    required this.controller,
    this.labelText,
    this.validator,
    required this.inputType,
    required this.obscure,
    this.iconPrefix,
    this.iconSuffix,
    required this.autofocus,
    required this.inputBorderType,
    required this.sizeInputBorder,
    this.colorBorderInput,
    this.paddingLeftInput,
    this.enable,
    this.onChanged,
    this.hintText,
    this.filled,
    this.fillColor, 
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    // Define o estilo de borda a ser utilizado, com a cor e a espessura configuradas
    final borderSideStyle = widget.inputBorderType.copyWith(
      borderSide: BorderSide(
        color: widget.colorBorderInput ?? ColorSchemeManagerClass.colorPrimary,
        width: widget.sizeInputBorder,
      ),
    );
    return TextFormField(
      cursorColor: ColorSchemeManagerClass.colorBlack,  // Cor do cursor no campo
      onChanged: widget.onChanged ?? (String? value) {},  // Callback para mudanças no texto
      enabled: widget.enable ?? true,  // Verifica se o campo é habilitado
      autofocus: widget.autofocus,  // Se o campo deve ser autofocus
      keyboardType: widget.inputType,  // Tipo de teclado que será exibido
      obscureText: widget.obscure,  // Se o texto será mascarado (senha)
      controller: widget.controller,  // Controlador de texto do campo
      style: TextStyle(color: ColorSchemeManagerClass.colorBlack),  // Estilo do texto no campo
      decoration: InputDecoration(
        fillColor: widget.fillColor,  // Cor de fundo do campo
        filled: widget.filled ?? false,  // Se o campo terá fundo preenchido
        hintText: widget.hintText,  // Texto a ser exibido quando o campo está vazio
        prefixIcon: widget.iconPrefix,  // Ícone à esquerda do campo
        suffixIcon: widget.iconSuffix,  // Ícone à direita do campo
        labelText: widget.labelText,  // Rótulo do campo
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: widget.paddingLeftInput ?? 20.0),  // Padding interno do campo
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,  // Estilo do rótulo
        ),
        enabledBorder: borderSideStyle,  // Borda quando o campo está habilitado
        focusedBorder: borderSideStyle,  // Borda quando o campo está em foco
        border: borderSideStyle,  // Borda geral do campo
        errorStyle: const TextStyle(height: 1.1),  // Estilo de erro
        helperText: ' ',  // Texto de ajuda (não exibido)
      ),
      validator: widget.validator,  // Função de validação do campo
    );
  }
}
