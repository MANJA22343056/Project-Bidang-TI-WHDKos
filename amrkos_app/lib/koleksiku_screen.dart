import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart'; 
// Import model KosItem dari main_dashboard_screen
import 'main_dashboard_screen.dart'; 

class KoleksikuScreen extends StatefulWidget {
  const KoleksikuScreen({Key? key}) : super(key: key);

  @override
  State<KoleksikuScreen> createState() => _KoleksikuScreenState();
}

class _KoleksikuScreenState extends State<KoleksikuScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final Color amrkosBlue = const Color(0xFF00AEEF);

  // Fungsi untuk mengambil ID Kos yang tersimpan
  Future<List<String>> _fetchSavedKosIds() async {
    if (currentUser == null) return [];
    
    // Ambil semua dokumen di sub-koleksi 'saved_kosts'
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('saved_kosts')
        .get();
        
    return snapshot.docs.map((doc) => doc.id).toList();
  }

  // Fungsi untuk mengambil detail Kos berdasarkan ID yang tersimpan
  Future<List<KosItem>> _fetchSavedKosDetails(List<String> kosIds) async {
    if (kosIds.isEmpty) return [];
    
    // Batasan Firestore: whereIn hanya bisa hingga 10 item. 
    // Kita asumsikan jumlah kos tersimpan kurang dari 10.
    final snapshot = await FirebaseFirestore.instance
        .collection('kosts_padang')
        .where(FieldPath.documentId, whereIn: kosIds)
        .get();
        
    return snapshot.docs.map((doc) => KosItem.fromFirestore(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Koleksiku'), backgroundColor: Colors.white),
        body: const Center(child: Text('Anda harus login untuk melihat koleksi Anda.')),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koleksiku (Kos Tersimpan)'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<String>>(
        future: _fetchSavedKosIds(),
        builder: (context, snapshotIds) {
          if (snapshotIds.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final savedIds = snapshotIds.data ?? [];
          
          if (savedIds.isEmpty) {
            return const Center(child: Text('Tidak ada kos yang tersimpan.'));
          }
          
          // Lanjutkan mengambil detail Kos
          return FutureBuilder<List<KosItem>>(
            future: _fetchSavedKosDetails(savedIds),
            builder: (context, snapshotDetails) {
              if (snapshotDetails.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshotDetails.hasError) {
                return Center(child: Text('Error: ${snapshotDetails.error}'));
              }
              
              final savedKosList = snapshotDetails.data ?? [];
              
              // Tampilkan dalam ListView sederhana
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: savedKosList.length,
                itemBuilder: (context, index) {
                  final kos = savedKosList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: kos.imageUrl, 
                          width: 60, 
                          height: 60, 
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(color: Colors.grey[200]),
                          errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                        ),
                      ),
                      title: Text(kos.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(kos.location),
                      trailing: Text(
                        'Rp. ${kos.price}',
                        style: TextStyle(color: amrkosBlue, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        // Opsi: Tambahkan navigasi ke halaman detail kos jika ada
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}