import 'package:flutter/material.dart';

/// Notificador de conexão para gerenciar o estado da conexão com a internet.
///
/// Utiliza o [InheritedNotifier] para notificar os widgets dependentes quando
/// o estado da conexão mudar. A classe armazena um [ValueNotifier<bool>] que
/// indica se a conexão com a internet está ativa ou não.
class ConnectionNotifier extends InheritedNotifier<ValueNotifier<bool>> {
  /// Construtor da classe [ConnectionNotifier].
  ///
  /// Recebe o [notifier] que gerencia o estado da conexão e o [child]
  /// que é o widget que ficará abaixo do [ConnectionNotifier] na árvore de widgets.
  const ConnectionNotifier({
    super.key, 
    required super.notifier, 
    required super.child,
  });

  /// Método para acessar o [ValueNotifier<bool>] de conexão a partir do [BuildContext].
  ///
  /// Esse método permite que qualquer widget que precise saber sobre o estado da
  /// conexão possa acessar o [notifier] diretamente, tornando-se dependente
  /// do estado da conexão.
  static ValueNotifier<bool> of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ConnectionNotifier>()!.notifier!;
  }
}
