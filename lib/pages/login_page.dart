import 'package:flutter/material.dart';
import 'package:logger/colors.dart';
import 'package:logger/services/supabase_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final SupabaseService _supabaseService = SupabaseService();

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      await _supabaseService.signInWithGoogle();
      // Se il login ha successo, main.dart si accorgerà del cambio di stato
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore durante il login: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteSmoke,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo o Icona
              Image.asset(
                'assets/icons/logger_logo.png',
                height: 120,
              ),
              const SizedBox(height: 40),
              const Text(
                'Bentornato su Logger',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.onyx,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Accedi per gestire i tuoi log giornalieri',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 50),
              
              if (_isLoading)
                const CircularProgressIndicator(color: CustomColors.orange)
              else
                ElevatedButton.icon(
                  onPressed: _handleGoogleSignIn,
                  icon: const FaIcon(FontAwesomeIcons.google, color: Colors.white, size: 20),
                  label: const Text(
                    'Accedi con Google',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.orange,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
