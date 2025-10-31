import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main_dashboard_screen.dart'; // Dashboard untuk user
import 'admin_dashboard_screen.dart'; // Dashboard untuk admin

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller untuk mengambil teks dari text field
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isLoading = false; // State untuk loading indicator

  // Fungsi utama untuk login dan pengecekan role
  Future<void> _signInAndNavigate() async {
    // 1. Tampilkan loading
    setState(() {
      _isLoading = true;
    });

    try {
      // 2. Coba login dengan Firebase Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      // 3. Cek "role" pengguna di Firestore
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      String userRole = "user"; // Default role
      if (userDoc.exists) {
        // Coba ambil role, jika tidak ada, tetap "user"
        userRole = (userDoc.data() as Map<String, dynamic>)['role'] ?? 'user';
      }
      
      // Hentikan loading
      setState(() { _isLoading = false; });

      // 4. Navigasi berdasarkan role
      if (userRole == 'admin') {
        // --- INI ADMIN ---
        // Navigasi "soft" ke Admin Dashboard
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const AdminDashboardScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
          (route) => false,
        );
      } else {
        // --- INI USER BIASA ---
        // Navigasi "soft" ke User Dashboard
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MainDashboardScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      // 5. Handle Error (password salah, user tidak ditemukan, dll)
      setState(() {
        _isLoading = false;
      });
      String message = 'Terjadi kesalahan.';
      if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        message = 'Email atau password salah.';
      } else if (e.code == 'invalid-email') {
        message = 'Format email tidak valid.';
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color amrkosBlue = const Color(0xFF0077C2);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Masuk',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Image.asset(
                'assets/images/Logo.png',
                height: 80,
              ),
              const SizedBox(height: 48),

              // Form Email
              _buildTextField(
                controller: _emailController, // Hubungkan controller
                label: 'Email',
                hint: 'Alamat Email Anda',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),

              // Form Kata Sandi
              _buildTextField(
                controller: _passwordController, // Hubungkan controller
                label: 'Kata Sandi',
                hint: 'Masukkan Kata Sandi',
                isObscure: _isPasswordObscured,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordObscured
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordObscured = !_isPasswordObscured;
                    });
                  },
                ),
              ),
              const SizedBox(height: 48),

              // Tombol Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // Panggil fungsi _signInAndNavigate saat ditekan
                  onPressed: _isLoading ? null : _signInAndNavigate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: amrkosBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper untuk membuat text field
  Widget _buildTextField({
    required TextEditingController controller, // Terima controller
    required String label,
    required String hint,
    bool isObscure = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    final Color borderColor = Colors.grey[400] ?? Colors.grey;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller, // Set controller
          obscureText: isObscure,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            suffixIcon: suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: const Color(0xFF00AEEF), width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}