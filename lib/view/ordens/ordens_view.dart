import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrdensPage extends StatefulWidget {
  const OrdensPage({super.key});

  @override
  State<OrdensPage> createState() => _OrdensPageState();
}

class _OrdensPageState extends State<OrdensPage> {
  final supabase = Supabase.instance.client;

  final _numeroController = TextEditingController();
  final _dataAberturaController = TextEditingController();
  final _nomeConsumidorController = TextEditingController();
  final _cpfController = TextEditingController();
  final _defeitoController = TextEditingController();
  final _solucaoController = TextEditingController();

  List<dynamic> produtos = [];
  String? produtoSelecionado;

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  Future<void> carregarProdutos() async {
    final response = await supabase.from('produtos').select();
    setState(() {
      produtos = response;
    });
  }

  Future<void> salvar() async {
    final numero = _numeroController.text.trim();
    final dataAbertura = _dataAberturaController.text.trim();
    final nomeConsumidor = _nomeConsumidorController.text.trim();
    final cpf = _cpfController.text.trim();
    final defeito = _defeitoController.text.trim();
    final solucao = _solucaoController.text.trim();

    if ([
      numero,
      dataAbertura,
      nomeConsumidor,
      cpf,
      defeito,
      produtoSelecionado,
    ].any((e) => e == null || e.isEmpty)) {
      showToast('Preencha todos os campos obrigatórios');
      return;
    }

    try {
      await supabase.from('ordens').insert({
        'numero_order': numero,
        'data_abertura': dataAbertura,
        'nome_consum': nomeConsumidor,
        'cpf_consumid': cpf,
        'defeito_reclar': defeito,
        'solucao_tecnic': solucao,
        'produto_id': produtoSelecionado,
        'user_id': supabase.auth.currentUser?.id, // se for obrigatório
      });

      _numeroController.clear();
      _dataAberturaController.clear();
      _nomeConsumidorController.clear();
      _cpfController.clear();
      _defeitoController.clear();
      _solucaoController.clear();
      setState(() => produtoSelecionado = null);

      showToast('Ordem cadastrada com sucesso!');
    } catch (e) {
      showToast('Erro ao cadastrar ordem');
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
      appBar: AppBar(title: const Text('Ordens')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _numeroController,
              decoration: const InputDecoration(labelText: 'Número ordem'),
            ),
            TextField(
              controller: _dataAberturaController,
              readOnly: true,
              decoration: const InputDecoration(labelText: 'Data abertura'),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (picked != null) {
                  final dataFormatada =
                      "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                  setState(() {
                    _dataAberturaController.text = dataFormatada;
                  });
                }
              },
            ),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Produto'),
              value: produtoSelecionado,
              items:
                  produtos.map((produto) {
                    return DropdownMenuItem(
                      value: produto['id'].toString(),
                      child: Text(produto['nome']),
                    );
                  }).toList(),
              onChanged: (value) => setState(() => produtoSelecionado = value),
            ),
            TextField(
              controller: _nomeConsumidorController,
              decoration: const InputDecoration(labelText: 'Nome consumidor'),
            ),
            TextField(
              controller: _cpfController,
              decoration: const InputDecoration(labelText: 'CPF'),
            ),
            TextField(
              controller: _defeitoController,
              decoration: const InputDecoration(labelText: 'Defeito'),
            ),
            TextField(
              controller: _solucaoController,
              decoration: const InputDecoration(labelText: 'Solução'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvar,
              child: const Text('Cadastrar Ordem'),
            ),
          ],
        ),
      ),
    );
  }
}
