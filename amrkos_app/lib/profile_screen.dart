import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final String email = user?.email ?? 'Tidak terdeteksi (Belum Login)';
    final String uid = user?.uid ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Akun'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle, size: 100, color: Colors.grey),
              const SizedBox(height: 24),
              Text(
                'Email Pengguna:',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              Text(
                email,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'User ID:',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              Text(
                uid,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}