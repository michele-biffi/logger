import 'package:flutter/material.dart';
import 'package:logger/colors.dart';
import 'package:logger/services/supabase_service.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});

  final SupabaseService _supabaseService = SupabaseService();

  @override
  Widget build(BuildContext context) {
    final user = _supabaseService.currentUser;
    final userMetadata = user?.userMetadata;
    
    final String name = userMetadata?['full_name'] ?? 'Utente';
    final String? avatarUrl = userMetadata?['avatar_url'];
    final String email = user?.email ?? '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: CustomColors.orange, width: 2),
          ),
          child: ClipOval(
            child: avatarUrl != null
                ? Image.network(avatarUrl, fit: BoxFit.cover)
                : const Icon(Icons.person, size: 50, color: CustomColors.orange),
          ),
        ),
        const SizedBox(height: 25),
        Text(
          name,
          style: const TextStyle(
            fontSize: 24,
            color: CustomColors.onyx,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          email,
          style: const TextStyle(color: Colors.black54, fontSize: 14),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 35),
        
        // Pulsante Logout
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ElevatedButton(
            onPressed: () async {
              await _supabaseService.signOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
