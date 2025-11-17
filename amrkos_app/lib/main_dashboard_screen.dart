import 'package:flutter/material.dart';

// --- BAGIAN DATA MODEL (Nantinya diganti dari API) ---
// Model sederhana untuk data kos
class KosItem {
  final String imageUrl;
  final String type; // "Putra", "Putri", "Campur"
  final String name;
  final double rating;
  final String location; // Menyimpan lokasi spesifik
  final String price;

  KosItem({
    required this.imageUrl,
    required this.type,
    required this.name,
    required this.rating,
    required this.location,
    required this.price,
  });
}

// Data dummy KOS DI PADANG
final List<KosItem> popularKos = [
  KosItem(
    // Gambar Kos dekat pantai
    imageUrl: 'https://images.unsplash.com/photo-1627960114945-812e9b81e4b8?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    type: 'Putra',
    name: 'Kos Sejuk Padang Baru',
    rating: 4.7,
    location: 'Padang Barat, Kota Padang',
    price: '1.400.000',
  ),
  KosItem(
    // Gambar Kos Modern
    imageUrl: 'https://images.unsplash.com/photo-1594950454747-0ec1ce489c74?q=80&w=1969&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    type: 'Putri',
    name: 'Kos Bundo Kanduang',
    rating: 4.8,
    location: 'Belakang Kampus UNP, Padang Utara',
    price: '1.100.000',
  ),
  KosItem(
    // Gambar Kos Sederhana
    imageUrl: 'https://images.unsplash.com/photo-1549247767-f673e721a37c?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    type: 'Campur',
    name: 'Kos Elang Sentosa',
    rating: 4.3,
    location: 'Siteba, Kuranji, Kota Padang',
    price: '950.000',
  ),
];

// Data dummy KOS DEKAT UNIVERSITAS DI PADANG
final List<KosItem> universitasKos = [
  KosItem(
    // Gambar Kos dekat jalan
    imageUrl: 'https://images.unsplash.com/photo-1595562726415-4673663b6555?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    type: 'Putra',
    name: 'Kos Andalas Residence',
    rating: 4.5,
    location: 'Dekat Kampus Unand, Limau Manis',
    price: '1.300.000',
  ),
  KosItem(
    // Gambar Kos Minimalis
    imageUrl: 'https://images.unsplash.com/photo-1570191834167-16782c5f590d?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    type: 'Putri',
    name: 'Kos Syariah Air Tawar',
    rating: 4.9,
    location: 'Dekat Kampus UNP, Air Tawar',
    price: '850.000',
  ),
  KosItem(
    // Gambar Kos besar
    imageUrl: 'https://images.unsplash.com/photo-1589252631558-7c870a3594b9?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    type: 'Campur',
    name: 'Kos Merdeka Jati',
    rating: 4.2,
    location: 'Jati, Dekat Kampus Bung Hatta',
    price: '1.000.000',
  ),
];

// Data dummy KOS DEKAT STASIUN DI PADANG (Stasiun Padang/Simpang Haru)
final List<KosItem> stasiunKos = [
  KosItem(
    // Gambar Kos dekat stasiun
    imageUrl: 'https://images.unsplash.com/photo-1574441617255-e7af55440c9d?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    type: 'Putra',
    name: 'Kos Garuda Stasiun',
    rating: 4.1,
    location: 'Belakang Stasiun Padang',
    price: '750.000',
  ),
  KosItem(
    // Gambar Kos berwarna cerah
    imageUrl: 'https://images.unsplash.com/photo-1588691880486-ed50e93b827e?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    type: 'Putri',
    name: 'Kos Anggrek Simpang Haru',
    rating: 4.6,
    location: 'Dekat Stasiun Simpang Haru',
    price: '850.000',
  ),
  KosItem(
    // Gambar Kos dengan pagar
    imageUrl: 'https://images.unsplash.com/photo-1627885741009-880629a8a729?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    type: 'Putra',
    name: 'Kos Raya Tabiang',
    rating: 4.3,
    location: 'Dekat Stasiun Tabiang, Padang',
    price: '800.000',
  ),
];
// --- AKHIR BAGIAN DATA MODEL ---


class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({Key? key}) : super(key: key);

  @override
  _MainDashboardScreenState createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _selectedIndex = 0; // Untuk Bottom Navigation Bar

  // Helper untuk warna
  static const Color amrkosBlue = Color(0xFF00AEEF);
  static Color amrkosBlueLight = amrkosBlue.withOpacity(0.1);

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
        child: Image.asset('assets/images/Logo.png'), // Logo Anda
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
          onPressed: () {
            // TODO: Aksi notifikasi
          },
        ),
        IconButton(
          icon: const Icon(Icons.person_outline, color: Colors.black54),
          onPressed: () {
            // TODO: Aksi profil
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // --- WIDGET UNTUK BODY KONTEN ---
  Widget _buildBody() {
    // SingleChildScrollView agar seluruh halaman bisa di-scroll
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMainSearch(), // Search bar utama
          _buildSectionTitle('Popular di Padang'),
          _buildHorizontalList(popularKos), // List horizontal
          _buildSectionTitle('Kos Dekat Universitas Padang'),
          _buildSectionSearch('Cari Universitas'),
          // PENTING: Ganti popularKos.reversed.toList() dengan universitasKos
          _buildHorizontalList(universitasKos), // List horizontal (dengan data universitasKos)
          _buildSectionTitle('Kos Dekat Stasiun Padang'),
          _buildSectionSearch('Cari Stasiun'),
          _buildVerticalList(stasiunKos), // List vertikal
        ],
      ),
    );
  }

  // --- WIDGET HELPER ---

  Widget _buildMainSearch() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari lokasi kos (mis: Padang Utara)',
                prefixIcon: Icon(Icons.search, color: amrkosBlue),
                filled: true,
                fillColor: amrkosBlueLight,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              // TODO: Aksi tombol cari
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black54,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            ),
            child: const Text('Cari'),
          ),
        ],
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

  Widget _buildSectionSearch(String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // List horizontal untuk "Popular" dan "Universitas"
  Widget _buildHorizontalList(List<KosItem> items) {
    return Container(
      height: 240, // Tinggi tetap untuk list horizontal
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: items.length, 
        itemBuilder: (context, index) {
          final kos = items[index]; 
          return _buildHorizontalCard(kos);
        },
      ),
    );
  }

  Widget _buildHorizontalCard(KosItem kos) {
    return Container(
      width: 160, // Lebar tetap untuk card horizontal
      margin: const EdgeInsets.only(right: 12.0),
      child: Card(
        clipBehavior: Clip.antiAlias, // Untuk memotong gambar agar rounded
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        shadowColor: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ganti Image.network dengan Widget yang mendukung Cached Network Image jika Anda menggunakannya
            Image.network(
              kos.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kos.type,
                    style: TextStyle(fontSize: 10, color: amrkosBlue),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    kos.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow[700], size: 14),
                      Text(' ${kos.rating}', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp. ${kos.price}/bulan',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // List vertikal untuk "Stasiun"
  Widget _buildVerticalList(List<KosItem> items) {
    // Gunakan ListView.builder dengan shrinkWrap dan physics
    // agar bisa berada di dalam SingleChildScrollView
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Non-scrollable
      itemCount: items.length,
      itemBuilder: (context, index) {
        final kos = items[index];
        return _buildVerticalCard(kos);
      },
    );
  }

  Widget _buildVerticalCard(KosItem kos) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        shadowColor: Colors.grey[100],
        child: Column(
          children: [
            Image.network(
              kos.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
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
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.grey[600], size: 16),
                      const SizedBox(width: 4),
                      // Expanded agar teks lokasi tidak overflow
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET UNTUK BOTTOM NAVIGATION BAR ---
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        // TODO: Tambahkan logika navigasi untuk tiap tab
      },
      type: BottomNavigationBarType.fixed, // Agar 4 item terlihat semua
      selectedItemColor: amrkosBlue,
      unselectedItemColor: Colors.grey[600],
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
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