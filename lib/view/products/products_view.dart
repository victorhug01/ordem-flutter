import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final supabase = Supabase.instance.client;

  final _codigoController = TextEditingController();
  final _nomeController = TextEditingController();
  final _tempoGarantiaController = TextEditingController();

  bool status = false;

  Future<void> salvar() async {
    final codigo = _codigoController.text.trim();
    final nome = _nomeController.text.trim();
    final tempoGarantia = int.tryParse(_tempoGarantiaController.text.trim());

    if (codigo.isEmpty || nome.isEmpty || tempoGarantia == null) {
      showToast('Preencha todos os campos corretamente');
      return;
    }

    try {
      await supabase.from('produtos').insert({
        'codigo': codigo,
        'nome': nome,
        'tempo_garantia': tempoGarantia,
        'status': status,
      });

      _codigoController.clear();
      _nomeController.clear();
      _tempoGarantiaController.clear();
      setState(() => status = false);

      showToast('Produto cadastrado com sucesso!');
    } catch (e) {
      showToast('Erro ao cadastrar produto');
    }
  }

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _codigoController,
              decoration: const InputDecoration(labelText: 'Código'),
            ),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _tempoGarantiaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Garantia (meses)'),
            ),
            SwitchListTile(
              value: status,
              onChanged: (val) => setState(() => status = val),
              title: const Text('Status Ativo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvar,
              child: const Text('Cadastrar Produto'),
            )
          ],
        ),
      ),
    );
  }
}
