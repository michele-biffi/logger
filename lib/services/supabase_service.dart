import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/models/log.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const _webClientId =
      '1089707199746-rvddj1o6v612b0sq8jl7avnt3ejedumf.apps.googleusercontent.com';

  final SupabaseClient _client = Supabase.instance.client;
  final GoogleSignIn _googleSignIn = GoogleSignIn(serverClientId: _webClientId);

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get onAuthStateChange => _client.auth.onAuthStateChange;

  Future<void> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;

    if (googleAuth?.idToken == null || googleAuth?.accessToken == null) {
      throw 'No Google ID Token found.';
    }

    await _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: googleAuth!.idToken!,
      accessToken: googleAuth.accessToken!,
    );
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<List<Log>> getLogsForDay(DateTime day) async {
    final startOfDay = DateTime(day.year, day.month, day.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final response = await _client
        .from('daily_logs')
        .select()
        .gte('created_at', startOfDay.toIso8601String())
        .lt('created_at', endOfDay.toIso8601String())
        .order('start_time', ascending: true);

    return (response as List).map((log) => Log.fromJson(log)).toList();
  }

  Future<void> addLog(Log log) async {
    await _client.from('daily_logs').insert(log.toJson());
  }
}
