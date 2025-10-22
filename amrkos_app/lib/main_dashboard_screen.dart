import 'package:flutter/material.dart';

// --- BAGIAN DATA MODEL (Nantinya diganti dari API) ---
// Model sederhana untuk data kos
class KosItem {
  final String imageUrl;
  final String type; // "Putra", "Putri", "Campur"
  final String name;
  final double rating;
  final String location;
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

// Data dummy
final List<KosItem> popularKos = [
  KosItem(
    imageUrl: 'https://picsum.photos/seed/kos1/200/300',
    type: 'Putra',
    name: 'Kos Cempaka Putih',
    rating: 4.5,
    location: 'Jl. Melati Putih No. 12',
    price: '1.200.000',
  ),
  KosItem(
    imageUrl: 'https://picsum.photos/seed/kos2/200/300',
    type: 'Putri',
    name: 'Kos Duri Sejati',
    rating: 4.8,
    location: 'Jl. Merdeka No. 1',
    price: '1.500.000',
  ),
  KosItem(
    imageUrl: 'https://picsum.photos/seed/kos3/200/300',
    type: 'Campur',
    name: 'Kos Griya Asri',
    rating: 4.2,
    location: 'Jl. Soekarno Hatta',
    price: '900.000',
  ),
];

final List<KosItem> stasiunKos = [
  KosItem(
    imageUrl: 'https://picsum.photos/seed/kos4/300/200',
    type: 'Putra',
    name: 'Kos Kenanga Pasar IV',
    rating: 4.2,
    location: 'Jl. Bunga Wijaya Kusuma No. 12',
    price: '750.000',
  ),
  KosItem(
    imageUrl: 'https://picsum.photos/seed/kos5/300/200',
    type: 'Putri',
    name: 'Kos Cendana Central',
    rating: 4.9,
    location: 'Jl. Balaidesa Bendaneka No. 20',
    price: '850.000',
  ),
  KosItem(
    imageUrl: 'https://picsum.photos/seed/kos6/300/200',
    type: 'Putra',
    name: 'Kos Cemara',
    rating: 4.3,
    location: 'Jl. Sembada Ujung No. 96',
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
          _buildSectionTitle('Popular'),
          _buildHorizontalList(popularKos), // List horizontal
          _buildSectionTitle('Kos Dekat Universitas'),
          _buildSectionSearch('Cari Universitas'),
          _buildHorizontalList(popularKos.reversed.toList()), // List horizontal (pakai data dummy terbalik)
          _buildSectionTitle('Kos Dekat Stasiun'),
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
                hintText: 'Cari lokasi kos',
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
        itemCount: items.length, // TODO: Ganti dengan items.length
        itemBuilder: (context, index) {
          final kos = items[index]; // Ambil data dari list
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