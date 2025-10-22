import 'package:flutter/material.dart';
import 'daftar_screen.dart'; // Import halaman daftar
import 'login_screen.dart'; // <-- PASTIKAN IMPORT INI ADA
import 'main_dashboard_screen.dart'; // <-- TAMBAHKAN INI

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color buttonBlue = const Color(0xFF0077C2);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // 1. Ilustrasi Onboarding
              Image.asset('assets/images/onboarding_image.png', height: 250),

              const SizedBox(height: 32),

              // 2. Teks Caption
              Text(
                'Cari dan temukan kos kesukaan mu lebih mudah disini',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),

              const Spacer(flex: 3),

              // 3. Bagian Tombol-Tombol
              Column(
                children: [
                  // Tombol "Langsung Ke beranda"
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainDashboardScreen(),
                          ),
                          (Route<dynamic> route) => false, // Hapus semua route
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonBlue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Langsung Ke beranda',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Baris untuk tombol "Masuk" dan "Daftar"
                  Row(
                    children: [
                      // Tombol "Masuk"
                      Expanded(
                        child: OutlinedButton(
                          // --- PERUBAHAN DI SINI ---
                          onPressed: () {
                            // Navigasi "soft" (fade) ke LoginScreen
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const LoginScreen(),
                                transitionsBuilder:
                                    (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                transitionDuration: const Duration(
                                  milliseconds: 600,
                                ),
                              ),
                            );
                          },
                          // --- PERUBAHAN SELESAI ---
                          style: OutlinedButton.styleFrom(
                            foregroundColor: buttonBlue,
                            side: BorderSide(color: buttonBlue, width: 1.5),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Masuk',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Tombol "Daftar"
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Navigasi "soft" (fade) ke DaftarScreen
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const DaftarScreen(),
                                transitionsBuilder:
                                    (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                transitionDuration: const Duration(
                                  milliseconds: 600,
                                ),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: buttonBlue,
                            side: BorderSide(color: buttonBlue, width: 1.5),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Daftar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
