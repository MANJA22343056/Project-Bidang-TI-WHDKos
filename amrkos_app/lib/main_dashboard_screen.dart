import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart'; // <<< Diperlukan untuk Save

// Import Screens
import 'chat_screen.dart';
import 'profile_screen.dart'; 
import 'koleksiku_screen.dart'; // <<< Import KoleksikuScreen

// --- BAGIAN DATA MODEL & FIREBASE FUNCTIONS (OUTSIDE CLASS) ---

class KosItem {
  final String id; // <<< Document ID ditambahkan
  final String imageUrl;
  final String type; 
  final String name;
  final double rating;
  final String location;
  final String price;
  final String phone; 

  KosItem({
    required this.id, // <<< Wajib
    required this.imageUrl,
    required this.type,
    required this.name,
    required this.rating,
    required this.location,
    required this.price,
    required this.phone,
  });

  factory KosItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    double ratingValue = 0.0;
    if (data['rating'] is int) {
      ratingValue = (data['rating'] as int).toDouble();
    } else if (data['rating'] is double) {
      ratingValue = data['rating'] as double;
    }

    return KosItem(
      id: doc.id, // Ambil Document ID
      imageUrl: data['imageUrl'] ?? 'https://via.placeholder.com/300',
      type: data['type'] ?? 'N/A',
      name: data['name'] ?? 'Kos Tanpa Nama',
      rating: ratingValue, 
      location: data['location'] ?? 'Lokasi Tidak Diketahui',
      price: data['price'] ?? 'Rp. N/A',
      phone: data['phone'] ?? '', 
    );
  }
}

// Fungsi untuk mengambil data dari Firestore
Future<List<KosItem>> fetchKosData() async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('kosts_padang') 
        .get();

    return snapshot.docs.map((doc) => KosItem.fromFirestore(doc)).toList();

  } catch (e) {
    print("Error fetching kos data: $e");
    return [];
  }
}

// Fungsi untuk membuka chat WhatsApp
void _launchWhatsApp(BuildContext context, String phone) async {
  String formattedPhone = phone.startsWith('0') ? '62${phone.substring(1)}' : phone;
  final Uri url = Uri.parse("https://wa.me/$formattedPhone?text=Halo,%20saya%20tertarik%20dengan%20kos%20Anda.");
  
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tidak dapat membuka WhatsApp. Pastikan aplikasi terinstal.')),
    );
  }
}

// --- END FIREBASE FUNCTIONS ---


class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({Key? key}) : super(key: key);

  @override
  _MainDashboardScreenState createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _selectedIndex = 0; 
  
  static const Color amrkosBlue = Color(0xFF00AEEF);
  static Color amrkosBlueLight = amrkosBlue.withOpacity(0.1);

  // --- LOGIKA SAVE/UNSAVE ---
  
  // Cek apakah Kos sudah tersimpan
  Future<bool> _isKosSaved(String kosId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return false;
    
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('saved_kosts')
        .doc(kosId)
        .get();
        
    return doc.exists;
  }
  
  // Toggle status simpan (Save/Unsave)
  Future<void> _toggleSaveKos(String kosId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda harus login untuk menyimpan kos.')),
      );
      return;
    }
    
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('saved_kosts')
        .doc(kosId);
    
    try {
      final doc = await docRef.get();
      
      if (doc.exists) {
        // Hapus (Unsave)
        await docRef.delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kos dihapus dari Koleksi.')),
        );
      } else {
        // Simpan (Save)
        await docRef.set({'savedAt': FieldValue.serverTimestamp()});
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kos berhasil disimpan ke Koleksi!')),
        );
      }
      // Rebuild untuk memperbarui ikon Bookmark
      setState(() {}); 
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan: $e')),
      );
    }
  }


  // Navigasi (Diperbarui untuk 4 tombol)
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Index: 0=Beranda, 1=Koleksiku, 2=Chat, 3=Profil
    if (index == 1) { // Koleksiku
      Navigator.push(context, MaterialPageRoute(builder: (context) => const KoleksikuScreen()));
    } else if (index == 2) { // Chat
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
    } else if (index == 3) { // Profil
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(), 
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // --- WIDGET UNTUK APP BAR ---
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1.0,
      shadowColor: Colors.grey[200],
      leadingWidth: 40,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Image.asset('assets/images/Logo.png'),
      ),
      title: const Text(
        'Mudahnya ngekos',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_outlined, color: Colors.black54),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.person_outline, color: Colors.black54),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // --- WIDGET UNTUK BODY KONTEN (FutureBuilder) ---
  Widget _buildBody() {
    return FutureBuilder<List<KosItem>>(
      future: fetchKosData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: amrkosBlue));
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Gagal memuat atau tidak ada data kos. ${snapshot.error ?? ''}'));
        }

        final allKos = snapshot.data!;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMainSearch(), 
              _buildSectionTitle('Kos Air Tawar Barat'), 
              _buildVerticalList(allKos), 
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }

  // --- WIDGET HELPER ---
  Widget _buildMainSearch() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari kos', 
          prefixIcon: Icon(Icons.search, color: amrkosBlue),
          filled: true,
          fillColor: amrkosBlueLight,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (query) {
          // TODO: Logika pencarian/filter bisa ditambahkan di sini
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
  
  Widget _buildVerticalList(List<KosItem> items) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), 
      itemCount: items.length,
      itemBuilder: (context, index) {
        final kos = items[index];
        return _buildVerticalCard(context, kos);
      },
    );
  }

  // Card Vertikal (Diperbarui dengan Tombol Bookmark)
  Widget _buildVerticalCard(BuildContext context, KosItem kos) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        shadowColor: Colors.grey[100],
        child: Column(
          children: [
            Stack( // Menggunakan Stack untuk tombol bookmark
              children: [
                // Gambar
                CachedNetworkImage(
                  imageUrl: kos.imageUrl, 
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 150,
                    color: Colors.grey[200],
                    child: Center(child: Icon(Icons.image, size: 50, color: Colors.grey.shade500)),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 150,
                    color: Colors.red[50],
                    child: const Center(child: Icon(Icons.broken_image, color: Colors.red)),
                  ),
                ),
                
                // Tombol Save/Bookmark
                Positioned(
                  top: 8,
                  right: 8,
                  child: FutureBuilder<bool>(
                    future: _isKosSaved(kos.id),
                    builder: (context, snapshot) {
                      final isSaved = snapshot.data ?? false; // Default: belum tersimpan
                      return IconButton(
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: isSaved ? amrkosBlue : Colors.white,
                          size: 30,
                        ),
                        onPressed: () => _toggleSaveKos(kos.id),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            
            // Detail Kos (Tidak Berubah)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        kos.type,
                        style: TextStyle(fontSize: 12, color: amrkosBlue, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow[700], size: 16),
                          Text(' ${kos.rating}',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    kos.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.grey[600], size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          kos.location,
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp. ${kos.price}/bulan',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: amrkosBlue),
                  ),
                  const SizedBox(height: 12),
                  // Tombol Chat WhatsApp (Tidak Berubah)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _launchWhatsApp(context, kos.phone); 
                      },
                      icon: const Icon(Icons.chat_bubble, color: Colors.white), 
                      label: const Text(
                        'Chat Pemilik Kos',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25D366), 
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET UNTUK BOTTOM NAVIGATION BAR (4 Tombol) ---
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: amrkosBlue,
      unselectedItemColor: Colors.grey[600],
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem( // <<< Koleksiku Ditambahkan
          icon: Icon(Icons.bookmark_border),
          activeIcon: Icon(Icons.bookmark),
          label: 'Koleksiku',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          activeIcon: Icon(Icons.chat_bubble),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}