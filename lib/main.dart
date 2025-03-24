import 'package:cabeleleila/app/app.dart';
import 'package:cabeleleila/services/internet/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  final hasConnection = await InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 1),
    checkInterval: const Duration(seconds: 1),
  ).hasConnection;
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

    await Supabase.initialize(
    url: dotenv.env['SUPABSE_URL']!,
    anonKey: dotenv.env['SUPABSE_API_KEY']!,
  );

  runApp(ConnectionNotifier(notifier: ValueNotifier(hasConnection), child: const MyApp()));
}