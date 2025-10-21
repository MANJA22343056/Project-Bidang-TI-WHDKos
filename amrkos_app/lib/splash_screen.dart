import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // Impor halaman beranda

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAnimated = false; // Untuk animasi panel biru
  bool _showGradients = false; // Untuk animasi gradasi

  final Color amrkosBlue = const Color(0xFF00AEEF);
  final double gapWidth = 2.0;

  @override
  void initState() {
    super.initState();

    // 1. Memulai animasi panel biru
    Timer(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _isAnimated = true;
        });
      }
    });

    // 2. Memulai animasi gradasi (setelah panel mulai bergerak)
    Timer(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _showGradients = true;
        });
      }
    });

    // 3. Navigasi ke Halaman Beranda
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        // --- PERUBAHAN DIMULAI DI SINI ---
        // Kita ganti MaterialPageRoute dengan PageRouteBuilder

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            // Halaman tujuannya (HomeScreen)
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),

            // Efek transisinya
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  // Gunakan FadeTransition untuk efek "soft"
                  return FadeTransition(
                    opacity: animation, // Animasi opacity dari 0.0 ke 1.0
                    child: child,
                  );
                },

            // Atur durasi transisi fade-nya
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
        // --- PERUBAHAN SELESAI DI SINI ---
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double panelHeight = (screenHeight / 2) - gapWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ## LAPISAN 1: GRADASI DI LATAR BELAKANG ##
          AnimatedOpacity(
            opacity: _showGradients ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeIn,
            child: Stack(
              children: [
                // Gradasi Kanan Atas
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: screenWidth * 0.7,
                    height: screenHeight * 0.4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          amrkosBlue.withOpacity(0.2),
                          amrkosBlue.withOpacity(0.0),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                  ),
                ),
                // Gradasi Kiri Bawah
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: screenWidth * 0.7,
                    height: screenHeight * 0.4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          amrkosBlue.withOpacity(0.2),
                          amrkosBlue.withOpacity(0.0),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ## LAPISAN 2: LOGO (DI TENGAH) ##
          Center(
            child: SizedBox(
              width: 150,
              // Pastikan nama file Anda benar (Logo.png)
              child: Image.asset('assets/images/Logo.png'),
            ),
          ),

          // ## LAPISAN 3: PANEL ANIMASI (DI ATAS) ##

          // Panel Biru ATAS
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutCubic,
            width: screenWidth,
            height: panelHeight,
            top: _isAnimated ? -panelHeight : 0,
            left: 0,
            child: Container(color: amrkosBlue),
          ),

          // Panel Biru BAWAH
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutCubic,
            width: screenWidth,
            height: panelHeight,
            bottom: _isAnimated ? -panelHeight : 0,
            left: 0,
            child: Container(color: amrkosBlue),
          ),
        ],
      ),
    );
  }
}
