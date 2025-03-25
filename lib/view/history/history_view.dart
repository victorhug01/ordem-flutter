import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  //Página de historicos, incompleta por questao de tempo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Histórico'),
      ),
    );
  }
}