import 'package:supabase_flutter/supabase_flutter.dart';

/// Serviço que interage com a API do Supabase para autenticação e gerenciamento de dados.
///
/// Esta classe fornece métodos para autenticação de usuários, recuperação de senha,
/// atualização de dados de usuário e obtenção de serviços armazenados no banco de dados.
class SupabaseService {
  /// Instância do cliente Supabase para realizar operações.
  final supabase = Supabase.instance.client;

  /// Sessão atual do usuário autenticado.
  final session = Supabase.instance.client.auth.currentUser;

  /// Método para realizar o login de um usuário utilizando e-mail e senha.
  ///
  /// [email] e [password] são os dados de autenticação do usuário.
  /// Retorna um [AuthResponse] com o resultado da autenticação.
  Future<AuthResponse> signIn(String email, String password) async {
    return supabase.auth.signInWithPassword(password: password, email: email);
  }

  /// Método para registrar um novo usuário utilizando e-mail e senha.
  ///
  /// [email] e [password] são os dados para criar uma nova conta.
  /// Retorna um [AuthResponse] com o resultado do registro.
  Future<AuthResponse> signUp(String email, String password) async {
    return supabase.auth.signUp(password: password, email: email);
  }

  /// Método para enviar um e-mail de redefinição de senha.
  ///
  /// [email] é o e-mail do usuário para o qual será enviado o link de redefinição.
  /// Retorna um resultado da operação de redefinição de senha.
  Future resetPasswordForEmail(String email) async {
    return supabase.auth.resetPasswordForEmail(email);
  }

  /// Método para atualizar os dados do usuário autenticado.
  ///
  /// [password] é a nova senha a ser configurada para o usuário.
  /// Retorna o resultado da atualização do usuário.
  Future updateUser(String password) async {
    return supabase.auth.updateUser(UserAttributes(password: password));
  }

  /// Método para obter os serviços armazenados no banco de dados do Supabase.
  ///
  /// Retorna uma lista dos serviços disponíveis.
  Future getServices() async {
    return supabase.from('services').select();
  }

  /// Método para realizar o logout do usuário.
  ///
  /// Esse método encerra a sessão do usuário autenticado.
  Future signOut() async {
    supabase.auth.signOut();
  }
}
