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

  final userId = supabase.auth.currentUser?.id;

  debugPrint('📝 Dados inserção:');
  debugPrint('numero: $numero');
  debugPrint('data: $dataAbertura');
  debugPrint('nome: $nomeConsumidor');
  debugPrint('cpf: $cpf');
  debugPrint('defeito: $defeito');
  debugPrint('solucao: $solucao');
  debugPrint('produto_id: $produtoSelecionado');
  debugPrint('user_id: $userId');

  if ([numero, dataAbertura, nomeConsumidor, cpf, defeito, produtoSelecionado].any((e) => e == null || e.isEmpty)) {
    showToast('Preencha todos os campos obrigatórios');
    return;
  }

  if (userId == null) {
    showToast('Usuário não autenticado');
    return;
  }

  try {
    final response = await supabase.from('ordens_servico').insert({
      'numero_ordem': numero,
      'data_abertura': dataAbertura,
      'nome_consumidor': nomeConsumidor,
      'cpf_consumidor': cpf,
      'defeito_reclamado': defeito,
      'solucao_tecnico': solucao,
      'produto_id': produtoSelecionado,
      'user_id': userId,
    }).select();

    debugPrint('✅ Ordem criada: $response');
    showToast('Ordem cadastrada com sucesso!');

    _numeroController.clear();
    _dataAberturaController.clear();
    _nomeConsumidorController.clear();
    _cpfController.clear();
    _defeitoController.clear();
    _solucaoController.clear();
    setState(() => produtoSelecionado = null);

  } catch (e, stacktrace) {
    debugPrint('❌ Erro ao cadastrar ordem: $e');
    debugPrint('📍 Stacktrace: $stacktrace');
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
