import 'package:flutter/widgets.dart';

/// Classe utilitária para gerenciar a responsividade do aplicativo com base na largura da tela.
class ResponsiveUtils {
  /// Contexto do BuildContext para acessar as informações da tela.
  final BuildContext context;

  /// Construtor que recebe o contexto do aplicativo.
  ResponsiveUtils(this.context);

  /// Retorna a altura total da tela.
  double get height => MediaQuery.of(context).size.height;
  
  /// Retorna a largura total da tela.
  double get width => MediaQuery.of(context).size.width;

  /// Verifica se a tela é considerada um dispositivo móvel (largura até 479px).
  bool get isMobile => width <= 479;
  
  /// Verifica se a tela é considerada um tablet pequeno (largura entre 480px e 767px).
  bool get isTablet => width > 479 && width <= 767;
  
  /// Verifica se a tela é um tablet grande (largura entre 768px e 991px).
  bool get isTabletLarge => width > 767 && width <= 991;
  
  /// Verifica se a tela é um desktop padrão (largura entre 992px e 1250px).
  bool get isDesktop => width > 991 && width <= 1250;
  
  /// Verifica se a tela é um desktop grande (largura acima de 1250px).
  bool get isDesktopLarge => width > 1250;
}