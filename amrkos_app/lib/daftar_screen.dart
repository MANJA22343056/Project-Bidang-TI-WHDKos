import 'package:flutter/material.dart';

class DaftarScreen extends StatefulWidget {
  const DaftarScreen({Key? key}) : super(key: key);

  @override
  _DaftarScreenState createState() => _DaftarScreenState();
}

class _DaftarScreenState extends State<DaftarScreen> {
  // Variabel state untuk mengontrol visibilitas kata sandi
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    // Warna biru dari desain Anda
    final Color amrkosBlue = const Color(0xFF00AEEF);
    // Warna abu-abu untuk border text field
    final Color borderColor = Colors.grey[400] ?? Colors.grey;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Tombol kembali (otomatis ditambahkan oleh Navigator.push)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Daftar',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Menghilangkan bayangan
      ),
      body: SingleChildScrollView( // Agar bisa di-scroll saat keyboard muncul
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // 1. Logo
              Image.asset(
                'assets/images/Logo.png', // Pastikan nama file logo benar
                height: 80,
              ),
              const SizedBox(height: 32),

              // 2. Form Input
              _buildTextField(
                label: 'Nama',
                hint: 'Nama Lengkap Sesuai Identitas',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Nomor Handphone',
                hint: 'Nomor Handphone Anda',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Email',
                hint: 'Alamat Email Anda',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              
              // 3. Form Kata Sandi
              _buildTextField(
                label: 'Kata Sandi',
                hint: 'Minimal 8 Karakter',
                isObscure: _isPasswordObscured,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordObscured = !_isPasswordObscured;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              
              // 4. Form Ulangi Kata Sandi
              _buildTextField(
                label: 'Ulangi Kata Sandi',
                hint: 'Masukkan Kata Sandi Kembali',
                isObscure: _isConfirmPasswordObscured,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordObscured ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                    });
                  },
                ),
              ),
              const SizedBox(height: 32),

              // 5. Tombol Daftar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Tambahkan logika daftar
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: amrkosBlue.withOpacity(0.5), // Warna abu-abu di desain
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Daftar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 6. Link "Masuk"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sudah punya akun? ', style: TextStyle(color: Colors.grey[700])),
                  GestureDetector(
                    onTap: () {
                      // TODO: Tambahkan navigasi ke halaman Masuk
                    },
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        color: amrkosBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 7. Divider "Atau"
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Atau', style: TextStyle(color: Colors.grey[600])),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),
              const SizedBox(height: 32),

              // 8. Ikon Sosial Media
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon('assets/images/instagram_logo.png'),
                  const SizedBox(width: 24),
                  _buildSocialIcon('assets/images/google_logo.png'),
                  const SizedBox(width: 24),
                  _buildSocialIcon('assets/images/facebook_logo.png'),
                ],
              ),
              const SizedBox(height: 32),

              // 9. Kebijakan Privasi
              Text.rich(
                TextSpan(
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  children: [
                    const TextSpan(text: 'Dengan mendaftar, saya menyetujui\n'),
                    TextSpan(
                      text: 'Kebijakan Privasi',
                      style: TextStyle(
                        color: amrkosBlue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      // TODO: Tambahkan onTap untuk membuka kebijakan privasi
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper untuk membuat text field
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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

  // Widget helper untuk membuat ikon sosial
  Widget _buildSocialIcon(String assetPath) {
    return GestureDetector(
      onTap: () {
        // TODO: Tambahkan logika login sosial
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300] ?? Colors.grey),
        ),
        child: Image.asset(
          assetPath,
          height: 32, // Sesuaikan ukuran ikon
          width: 32,
        ),
      ),
    );
  }
}