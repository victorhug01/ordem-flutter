import 'package:cabeleleila/app/app.dart';
import 'package:cabeleleila/services/internet/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Verificação da conexão com a internet.
  final hasConnection = await InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 1),  // Define o tempo de espera para a verificação de conexão.
    checkInterval: const Duration(seconds: 1),  // Define o intervalo entre as verificações de conexão.
  ).hasConnection;  // Retorna verdadeiro se houver conexão com a internet.

  // Inicialização do Flutter.
  WidgetsFlutterBinding.ensureInitialized();  // Garante que o binding do Flutter esteja inicializado antes de chamar outros métodos.

  // Carregamento das variáveis de ambiente.
  await dotenv.load(fileName: ".env");  // Carrega as variáveis do arquivo .env, necessário para configurar o Supabase.

  // Inicialização do Supabase.
  await Supabase.initialize(
    url: dotenv.env['SUPABSE_URL']!,  // Recupera a URL do Supabase do arquivo .env.
    anonKey: dotenv.env['SUPABSE_API_KEY']!,  // Recupera a chave pública do Supabase do arquivo .env.
  );

  // Inicia o aplicativo com a verificação da conexão e o widget principal.
  runApp(ConnectionNotifier(
    notifier: ValueNotifier(hasConnection),  // Cria um ValueNotifier que monitora o estado da conexão.
    child: const MyApp(),  // O widget principal do aplicativo.
  ));
}
