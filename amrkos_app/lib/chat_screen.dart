import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Chat'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.history_toggle_off, size: 80, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                'Laman ini menampilkan riwayat klik chat ke WhatsApp.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const Text(
                '(Data riwayat belum diimplementasikan)',
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}