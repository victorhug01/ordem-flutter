import 'package:flutter/material.dart';

/// Classe abstrata para gerenciar o esquema de cores do aplicativo.
abstract class ColorSchemeManagerClass {
  /// Cor primária utilizada no aplicativo.
  static Color colorPrimary = const Color(0xff4A007B);
  
  /// Cor secundária utilizada no aplicativo.
  static Color colorSecondary = const Color(0xffffffff);
  
  /// Cor branca.
  static Color colorWhite = const Color(0xffffffff);
  
  /// Cor preta.
  static Color colorBlack = const Color(0xff000000);
  
  /// Cor utilizada para indicar erros ou estados perigosos.
  static Color colorDanger = const Color.fromARGB(255, 210, 50, 50);
  
  /// Cor utilizada para indicar sucesso ou ações corretas.
  static Color colorCorrect = const Color.fromARGB(255, 33, 153, 6);
  
  /// Cor cinza, geralmente usada para elementos neutros.
  static Color colorGrey = const Color.fromARGB(255, 73, 71, 71);
}