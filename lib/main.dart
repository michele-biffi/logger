import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/colors.dart';
import 'package:logger/pages/calendar_page.dart';
import 'package:logger/pages/home.dart';
import 'package:logger/pages/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: CustomColors.orange,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38, // default
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.black38, // non attivo
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: CustomColors.orange, // attivo
              width: 1,
            ),
          ),
          hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        ),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: HomePage(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/calendar': (context) => const CalendarPage(),
        '/profile': (context) => const UserPage(),
      },
    );
  }
}
