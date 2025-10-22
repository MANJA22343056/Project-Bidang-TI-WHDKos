import 'package:flutter/material.dart';
import 'main_dashboard_screen.dart'; // <-- TAMBAHKAN INI

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Variabel state untuk mengontrol visibilitas kata sandi
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    // Warna biru dari desain Anda
    final Color amrkosBlue = const Color(0xFF0077C2); // Biru tombol Login
    final Color borderColor = Colors.grey[400] ?? Colors.grey;

    return Scaffold(
      backgroundColor: Colors.white,
      // Kita tambahkan AppBar agar konsisten dengan halaman Daftar
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Masuk', // Judul halaman
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Menghilangkan bayangan
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 24), // Spasi dari AppBar
              // 1. Logo
              Image.asset(
                'assets/images/Logo.png', // Pastikan nama file logo benar
                height: 80,
              ),
              const SizedBox(height: 48), // Spasi lebih banyak
              // 2. Form Email
              _buildTextField(
                label: 'Email',
                hint: 'Alamat Email Anda',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),

              // 3. Form Kata Sandi
              _buildTextField(
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

              // 4. Tombol Login
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
                    backgroundColor: amrkosBlue, // Warna biru solid
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              // TODO: Anda bisa tambahkan link "Lupa Kata Sandi?"
              // dan "Belum punya akun? Daftar" di sini jika perlu
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper untuk membuat text field (sama seperti di DaftarScreen)
  Widget _buildTextField({
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
          obscureText: isObscure,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: const Color(0xFF00AEEF),
                width: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
