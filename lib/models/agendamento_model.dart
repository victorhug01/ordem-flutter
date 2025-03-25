/// Modelo que representa um agendamento no sistema.
///
/// Contém os IDs dos serviços selecionados para o agendamento e a data/hora
/// em que o agendamento será realizado.
class AgendamentoModel {
  /// Lista de IDs dos serviços selecionados para o agendamento.
  final List<int> servicosIds;
  
  /// Data e hora do agendamento.
  final DateTime dataHora;

  /// Construtor da classe AgendamentoModel.
  ///
  /// [servicosIds] é uma lista que contém os IDs dos serviços escolhidos.
  /// [dataHora] é a data e hora em que o agendamento será realizado.
  AgendamentoModel({
    required this.servicosIds,
    required this.dataHora,
  });
}
