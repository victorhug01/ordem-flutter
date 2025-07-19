import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  final session = Supabase.instance.client.auth.currentUser;

  Future<AuthResponse> signIn(String email, String password) async {
    return supabase.auth.signInWithPassword(password: password, email: email);
  }

  Future<AuthResponse> signUp(String email, String password) async {
    return supabase.auth.signUp(password: password, email: email);
  }

  Future resetPasswordForEmail(String email) async {
    return supabase.auth.resetPasswordForEmail(email);
  }

  Future updateUser(String password) async {
    return supabase.auth.updateUser(UserAttributes(password: password));
  }

  Future getServices() async {
    return supabase.from('services').select();
  }

  Future signOut() async {
    supabase.auth.signOut();
  }
}
