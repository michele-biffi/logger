import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Errore durante il login: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: CustomColors.orange,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: CustomColors.orange,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Logger',
                  style: TextStyle(
                    fontFamily: 'LogoFont',
                    color: Colors.white,
                    fontSize: 120,
                  ),
                ),
                const SizedBox(height: 40),

                if (_isLoading)
                  const CircularProgressIndicator(
                    color: CustomColors.whiteSmoke,
                  )
                else
                  ElevatedButton.icon(
                    onPressed: _handleGoogleSignIn,
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: const Text(
                      'Sign in with Google',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Colors.white, width: 1),
                      ),
                      elevation: 0,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
