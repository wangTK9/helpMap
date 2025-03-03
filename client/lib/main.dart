import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './layouts/main_layout.dart';
import './pages/login_screen.dart';
import './pages/edit_profile_page.dart';
import './pages/health_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setup();
  runApp(const MyApp());
}

// API mapbox call
Future<void> setup() async {
  await dotenv.load(
    fileName: ".env",
  );
  MapboxOptions.setAccessToken(
    dotenv.env["MAPBOX_ACCESS_TOKEN"]!,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 96, 199, 11)),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? LoginScreen()
          : const MainLayout(),
      routes: {
        "/home": (context) => const MainLayout(),
        '/edit-profile': (context) => EditProfilePage(),
        '/login': (context) => LoginScreen(),
        '/health': (context) => HealthDetailsScreen(),
      },
    );
  }
}
