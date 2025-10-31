import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // <-- 1. Import Core
import 'firebase_options.dart'; // <-- 2. Import Options (dari flutterfire)
import 'splash_screen.dart'; 

// 3. Ubah main menjadi async
void main() async {
  // 4. Pastikan Flutter siap
  WidgetsFlutterBinding.ensureInitialized();
  
  // 5. Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // 6. Jalankan aplikasi
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AMRkos App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}